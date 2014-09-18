class Bark 
  class Response
    
    # All OT responses are in json format.  The json is stored here as a hash (dictionary).
    attr_reader :json

    def initialize(request: {}) 
      raise 'No request passed' if request == {} or request.nil?
      # warn Bark::Error, 'Warning request is not valid, making it anyway.' if !request.valid?

      @json = {}

      req = Net::HTTP::Post.new(request.uri, initheader = {'Content-Type' =>'application/json'})
      res = Net::HTTP.start(request.uri.hostname, request.uri.port) do |http|
        req.body = request.json_payload
        http.request(req)
      end

      begin
        @json = JSON.parse(res.body) 
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
