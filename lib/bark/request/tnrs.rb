class Bark::Request::Tnrs < Bark::Request

    API_VERSION = 'v2'  
    SEARCH_BASE = [Bark::Request::BASE_URL, API_VERSION, 'tnrs'].join("/")  

    # Method: {parameters} 
    METHODS = { 
      tnrs_match_names: %i{},
      tnrs_contexts: %i{},
      tnrs_infer_context: %i{}, 
    }

    # node_ids or ott_ids are required in some cases, so this
    # will have to be cased 
    REQUIRED_PARAMS = {
    }

    mrp = {}
    
    REQUIRED_PARAMS.each do |k,v|
      v.each do |m|
        mrp[m].push(k) if mrp[m] 
        mrp[m] ||= [k]
      end
    end

    METHODS_REQUIRED_PARAMS = mrp

    def initialize(method: :tol_about, params: {})
      assign_options(method: method, params: params)
      build_uri if valid?
    end

    def assign_options(method: method, params: params)
      @method = method
      @params = params
      @params ||= {}
    end

    def valid?
      raise "Method #{@method} not recognized." if @method && !self.class::METHODS.keys.include?(@method)
      !@method.nil? && params_are_supported? && has_required_params?
    end

    def has_required_params?
     #case @method
     #when :foo  
     #end
      return true
    end

    def json_payload
      JSON.generate(@params)
    end

    private 

    # TODO: this doesn't feel right (or could be generalized out to superclass)
    def build_uri
      @uri = URI( SEARCH_BASE + '/' + send("#{@method}_url") )
    end

    def tnrs_match_names_url 
     'match_names' 
    end

    def tnrs_contexts_url
     'contexts'
    end

    def tnrs_infer_context_url
      'infer_context' 
    end 

  end
