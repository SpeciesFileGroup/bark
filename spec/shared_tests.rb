# Methods that call shared tests.

def run_tests(request_class, tests)
  tests.each do |t|
    context t.name do
      r = request_class.new(method: t.method, params: t.input)
      response = Bark::Response.new(request: r)

      t.tests.keys.each do |k|
        case k
        when 'of_type'
          specify k.to_s do
            of_type_test(response, t, t.tests[k][1]) 
          end
        when 'equals'
          t.tests[k].each_with_index do |subtest, i|
            key = subtest[0][0]
            value = subtest[0][1] 
            msg = subtest[1]
            specify "#{k} #{key}: #{value} (#{i})" do 
              expect(response.json[key]).to eq(value), msg
            end
          end
        when 'contains'
          t.tests[k].each_with_index do |subtest, i|
            key = subtest[0]
            msg = subtest[1]
            specify "#{k} #{key} (#{i})" do 
              expect(response.json[key]).to be_truthy
            end
          end
        when 'length_greater_than'
          t.tests[k].each_with_index do |subtest, i|
            key = subtest[0][0]
            len = subtest[0][1].to_i
            msg = subtest[1]
            specify "#{k} #{key}: #{len} (#{i})" do 
              expect(response.json[key].length > len ).to be(true), msg
            end
          end
        when 'deep_equals' 
          t.tests[k].each_with_index do |subtest, i|
            sub_response = response.json
            # could eval a string sensu python too
            subtest[0][0].each do |k|
              sub_response = sub_response[k]
            end
            value = subtest[0][1]
            msg = subtest[1]
            specify "#{k} #{subtest[0][0]}: #{value} (#{i})" do 
              expect(sub_response).to eq(value), msg
            end
          end

        else
          pending "Test engine for [ #{k} ] not yet finished."
        end
      end
    end
  end
end


def of_type_test(response, ot_test_instance, message)
  expect(response.result.class).to eq(ot_test_instance.result_type), message
end

