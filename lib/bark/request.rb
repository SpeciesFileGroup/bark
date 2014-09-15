class Bark
  class Request

    # Target API https://github.com/OpenTreeOfLife/opentree/wiki/Open-Tree-of-Life-APIs

    BASE_URL = 'http://api.opentreeoflife.org'

    attr_accessor :params, :method, :format
    attr_reader :search_url

    # TODO: super this
    def initialize(options = {})
      opts = {
        format:  Bark::Request::FORMAT,
        method:  :getSyntheticTree,
        params: { }
      }.merge!(options)

      assign_options(opts)
      build_url if valid?
    end

    def assign_options(opts)
      @method = opts[:method]
      @format = opts[:format]
      @params = opts[:params]
    end

    def search_url
      build_url
      @search_url
    end

    def response
      build_url
      if valid?
        Response.new(request: self)
      else
        false # raise?
      end
    end

    def params_are_supported? 
      return false if @method.nil?
      return true if self.class::METHODS[@method] == []
      @params.keys - self.class::METHODS[@method] == []
    end

    def has_required_params?
      return false if @method.nil?
      
      return true if self.class::METHODS_REQUIRED_PARAMS[@method].nil?
      self.class::METHODS_REQUIRED_PARAMS[@method].select{|v| !@params.keys.include?(v)} == []
    end

    # Stub for subclasses
    def valid?
      false
    end

    private 

    # Stub for subclasses 
    def build_url
      false
    end

  end
end
