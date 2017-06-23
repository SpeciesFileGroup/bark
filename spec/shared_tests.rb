# Methods that call shared tests.

def get_response(request)

end

def run_tests(request_class, tests)
  tests.each do |t|
    context t.name do
      r = request_class.new(method: t.method, params: t.input)

      t.tests.keys.each do |k|
       
        # we don't need a response 
        if k == 'parameters_error'
          specify k.to_s do
            msg = t.tests[k][1]
            expect(r.valid?).to eq(false), msg
            # TODO: possibly extend to see raised error  
          end

        # we do need a response
        else
          response = Bark::Response.new(request: r)
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
          when 'contains_error'
            specify "#{k}" do 
              msg = t.tests[k]
              expect(response.json['error']).to be_truthy, msg 
            end
          else
            pending "Test engine for [ #{k} ] not yet written."
          end
        end
      end
    end
  end
end


def of_type_test(response, ot_test_instance, message)
  expect(response.result.class).to eq(ot_test_instance.result_type), message
end

