class Bark
  class Response

    attr_reader :json

    def initialize(options = {}) 
      opts = {
        request: nil 
      }.merge!(options)

      raise if opts[:request].nil? || opts[:request].class != Bark::Request

      @json = {}
      @json = JSON.parse(Net::HTTP.get_response(URI.parse(opts[:request].search_url)).body)
    end

  end
end
