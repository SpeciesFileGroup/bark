class Bark::Request::GraphOfLife < Bark::Request

    API_VERSION = 'v2'  
    SEARCH_BASE = [Bark::Request::BASE_URL, API_VERSION, 'graph'].join("/")  

    # Method: {parameters} 
    METHODS = { 
      gol_about: %i{},
      gol_source_tree: %i{},
      gol_node_info: %i{}, #  tree_id "is superflous and can be ignored"
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
      case @method
      when :gol_of_life
      end
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

    def gol_about_url
     'about' 
    end

    def gol_source_tree_url
     'source_tree'
    end

    def gol_node_info_url
      'node_info' 
    end 


  end
