class Bark 
  class Response
    
    # All OT responses are in json format.  The json is stored here as a hash (dictionary).
    attr_reader :json

    def initialize(request: {}) 
      raise 'No request passed' if request == {} || request.nil?
      # warn Bark::Error, 'Warning request is not valid, making it anyway.' if !request.valid?

      @json = {}

      
      if [:get_study, :get_study_tree ].include?( request.method  )
        req = Net::HTTP::Get.new(request.uri)
      else
        req = Net::HTTP::Post.new(request.uri, initheader = {'Content-Type' =>'application/json'})
      end 
      
      res = Net::HTTP.start(request.uri.hostname, request.uri.port, use_ssl: true) do |http|
        req.body = request.json_payload
        http.request(req)
      end

      parse_json(res.body)
   end

    # Parse the json, and store it in @json.
    def parse_json(string)
      begin
        @json = JSON.parse(string) 
      rescue JSON::ParserError => e
        puts e.message
        ap request
      end
    end

    def request_succeeded?
      !@json['exception'] && !@json['error']
    end

    def request_failure_message
      @json['message']
    end

    def result
      @json
    end

  end
end
