# This module faciliates the use of shared tests used in R, Python, and here.  
# Those tests are provided in json format here https://github.com/OpenTreeOfLife/opentree-interfaces/tree/master/python/test
#
# {
#     "test_mrca_normal_input": {
#         "test_method": "tree_of_life_mrca",
#         "test_input": [412129, 536234],
#         "test_output": {
#              "of_type": "dict",
#              "passes": "'nearest_taxon_mrca_rank' == 'superorder'",
#              "contains": "nearest_taxon_mrca_ott_id"}
#          }
# }
#
#
module SharedTestsHelper


  class SymbolizableHash < Hash
    include Hashie::Extensions::SymbolizeKeys
  end

  # The location of the .json files
  TEST_SOURCE_BASE = 'https://raw.githubusercontent.com/OpenTreeOfLife/opentree-interfaces/master/python/test/'

  # Bade filenames for each test containg .json file
  TEST_FILES = %w{
    graph_of_life
    studies
    taxonomy
    tnrs
    tree_of_life
  } 

  shared_tests = {} 

  # Each test is instantiated as an OtTest.  
  # This is used internally only in the testing framework.
  class OtTest
    
    # The name of the test, displayed in the specification
    attr_accessor :name

    # The API wrapper method name to to call
    attr_accessor :method

    # A Hash of input values to be delivered in the JSON payload
    attr_accessor :input

    # A Hash of specifications, by keyword, as provided in 'tests'
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

    RESULT_TYPE_CLASSES = {
      'dict' => Hash
    }
 
    def method
      @method.to_sym
    end

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

  # An Array of OtTest objects
  SHARED_TESTS = shared_tests

  def self.of_type_test(response, ot_test_instance, message)
    expect(response.class).to eq(ot_test_instance.result_type, message)
  end
  
end
