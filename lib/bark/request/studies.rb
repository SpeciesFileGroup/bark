class Bark::Request::Studies < Bark::Request

    API_VERSION = 'v2'  
    INTERFACE = 'studies'
    FORMAT = 'json'
    SEARCH_BASE = [Bark::Request::BASE_URL, INTERFACE, API_VERSION].join("/") 

    METHODS = { 
      'studies/properties' => %w{},
      find_studies: %w{},
      study: %w{study_id},
      find_studies: %w{}, 
    }

    REQUIRED_PARAMS = {
      'studyID' => [:study],
    }

    mrp = {}
    REQUIRED_PARAMS.each do |k,v|
      v.each do |m|
        mrp[m].push(k) if mrp[m] 
        mrp[m] ||= [k]
      end
    end

    METHODS_REQUIRED_PARAMS = mrp

    attr_accessor :params, :method, :format
    attr_reader :search_url

    def initialize( method: :study_list, params: {})
      assign_options(method: method, params: params)
      build_url if valid?
    end

    def assign_options(method: method, params: params)
      @method = method
      @params = params
    end

    def valid?
      raise "Method #{@method} not recognized." if @method && !Bark::Request::Studies::METHODS.keys.include?(@method)
      !@method.nil? && params_are_supported? && has_required_params?
    end

    private 

    # TODO: this doesn't feel right
    def build_url
     @search_url = SEARCH_BASE +  '/' + @method.to_s  + send("#{@method}_url")
    end

    def study_url
      '/' + (@params[:study_id].nil? ? nil : "/#{@params[:study_id]}").to_s
    end

    def find_studies_url 
      ''
    end

    def find_trees_url
    end

    # assume everything has a properties url
    
    def tree_url

    end 

  end
