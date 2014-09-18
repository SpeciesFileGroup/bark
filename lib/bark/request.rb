class Bark
  class Request

    # Target API https://github.com/OpenTreeOfLife/opentree/wiki/Open-Tree-of-Life-APIs

    BASE_URL = 'http://devapi.opentreeoflife.org'
    attr_accessor :params, :method 
    attr_accessor :payload 
    attr_reader :uri

    # TODO: super this
    def initialize(options = {})
      opts = {
        format: 'foo', # Bark::Request::FORMAT,
        method: :getSyntheticTree,
        params: { }
      }.merge!(options)

      assign_options(opts)
      build_uri if valid?
    end

    def assign_options(opts)
      @method = opts[:method]
      @format = opts[:format]
      @params = opts[:params]

    end

    def uri
      build_uri
      @uri
    end

    def response
      build_uri
      if valid?
        Response.new(request: self)
      else
        false # raise?
      end
    end

    def params_are_supported? 
      return false if @method.nil?
      return true if self.class::METHODS[@method] == []
      @params.keys.map(&:to_sym) - self.class::METHODS[@method] == []
    end

    def has_required_params?
      return false if @method.nil?
      return true if self.class::METHODS_REQUIRED_PARAMS[@method].nil?
      self.class::METHODS_REQUIRED_PARAMS[@method].select{|v| !@params.keys.include?(v)} == []
    end

    # Stub for subclasses
    def valid?
    end

    # stub for uri
    def uri
      build_uri
      @uri
    end

    def json_payload
    end

    private 

    # Stub for subclasses 
    def build_uri
      false
    end

  end
end
