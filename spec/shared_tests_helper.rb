#  This module faciliates the use of shared tests used in R, Python, and herein. 
#
#  See https://github.com/OpenTreeOfLife/shared-api-tests  
#
module SharedTestsHelper

  # Instances are used to translate string-keyed hashes to symbolized keys.
  class SymbolizableHash < Hash
    include Hashie::Extensions::SymbolizeKeys
  end

  # The location/ of the .json files
  TEST_SOURCE_BASE = ' https://raw.githubusercontent.com/OpenTreeOfLife/shared-api-tests/master/'

  # Base filenames to test with.
  TEST_FILES = %w{
    graph_of_life
    studies
    taxonomy
    tnrs
    tree_of_life
  } 

  # Each set of tests is instantiated as an OtTest.  
  class OtTest
    # The name of the test, displayed in the specification
    attr_accessor :name

    # The API wrapper method name to to call. 
    attr_accessor :method

    # A Hash of input values to be delivered in the JSON payload
    attr_accessor :input

    # A Hash of specifications, by keyword, i.e. the value of "tests"
    #
    #   "tests": {
    #        "of_type": 
    #                   ["dict","Response is of wrong type"]
    #                   ,
    #        "equals":  [
    #                   [["nearest_taxon_mrca_rank","'superorder'"],"Fails that nearest_taxon_mrca_rank contains superorder"]
    #                   ],
    #        "contains": [
    #                   ["nearest_taxon_mrca_ott_id","Doesn't contain nearest_taxon_mrca_ott_id"]
    #                   ]
    #   }
    #
    attr_accessor :tests

    # Translates specified types to Ruby types
    RESULT_TYPE_CLASSES = {
      'dict' => Hash
    }

    # Getter translation of the method attribute.  
    def method
      @method.to_sym
    end

    # Translate the json result type provided in the json specification to a native Ruby value.
    def result_type
      if t = @tests['of_type']
        RESULT_TYPE_CLASSES[t.first]
      else
        nil 
      end
    end
  end

  def self.build_test(name, attributes)
    o = SharedTestsHelper::OtTest.new
    o.name = name
    o.method = attributes['test_function']
 
    i = attributes['test_input']

    if i.class == Hash
      h = SymbolizableHash.new()
      h.merge!(i)
      input =  h.symbolize_keys.to_h
    elsif i == "null" 
      input = nil
    else
      raise "Invalid input type [#{i}]."
    end

    o.input = input
    o.tests = attributes['tests']

    o
  end

  shared_tests = {} 

  begin
    # TODO: Nicely warn the user when the URL isn't present
    TEST_FILES.each do |file|
      shared_tests[file] = [] 
      uri = URI(TEST_SOURCE_BASE + file + '.json')
      json = JSON.parse(Net::HTTP.get_response(uri).body)

      json.keys.each do |k|
        shared_tests[file].push build_test(k, json[k])
      end
    end

  rescue JSON::ParserError
    puts "\n\n!! Warning, unable to build shared tests, some JSON doesn't parse."
  end

  # The Array of OtTest objects
  SHARED_TESTS = shared_tests

end
