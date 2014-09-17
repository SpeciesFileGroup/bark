
# A helper module to make use of shared tests developed for Python and R equivalents  
#
# {
#     "test_mrca_normal_input": {
#         "test_function": "tree_of_life_mrca",
#         "test_input": [412129, 536234],
#         "test_output": {
#              "of_type": "dict",
#              "passes": "'nearest_taxon_mrca_rank' == 'superorder'",
#              "contains": "nearest_taxon_mrca_ott_id"}
#          }
# }
#
module SharedTestsHelper

  TEST_SOURCE_BASE = 'https://raw.githubusercontent.com/OpenTreeOfLife/opentree-interfaces/master/python/test/'
  TEST_FILES = %w{
    tree_of_life.json
  } 

  shared_tests = []

  class OtTest
    attr_accessor :name, :function, :input, :output

    # return tests 
    def tests
      @output.keys.each do |k|
        send(k)
      end
    end

    def of_type
    end

    def passes
    end

    def contains
    end
  end

  def self.build_test(name, attributes)
    o = SharedTestsHelper::OtTest.new
    o.name = name

    o
    # do more stuff here
  end


  shared_tests = []

  begin
    # TODO: Nicely warn the user when the URL isn't present
    TEST_FILES.each do |file|
      uri = URI(TEST_SOURCE_BASE + file)
      json = JSON.parse(Net::HTTP.get_response(uri).body)

      json.keys.each do |k|
        shared_tests.push build_test(k, json[k])
      end
    end

  rescue JSON::ParserError
    puts "\n\n!! Warning, unable to build shared tests, the JSON doesn't parse."
  end

  SHARED_TESTS = shared_tests


end
