class Bark
  class Response
    attr_reader :json

    def initialize(request: {}) 
      # raise if opts[:request].nil? || opts[:request].class != Bark::Request
      # python ete

      @json = {}

      #      request.uri =  URI('http://devapi.opentreeoflife.org/v2/taxonomy/about')
      req = Net::HTTP::Post.new(request.uri)
      # req.set_form_data('from' => '2005-01-01', 'to' => '2005-03-31')

      res = Net::HTTP.start(request.uri.hostname, request.uri.port) do |http|
        http.request(req)
      end

      @json = JSON.parse(res.body) # Net::HTTP.post(URI.parse(opts[:request].search_url)).body)
    end

  end
end
