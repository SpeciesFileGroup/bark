class Bark::Request::TreeOfLife < Bark::Request

    API_VERSION = 'v2'  
    SEARCH_BASE = [Bark::Request::BASE_URL, API_VERSION, 'tree_of_life'].join("/")  

    # Method: {parameters} 
    METHODS = { 
      tol_about: %i{},
      tol_mrca: %i{node_ids ott_ids},
      tol_subtree: %i{node_id ott_id}, #  tree_id "is superflous and can be ignored"
      tol_induced_subtree: %i{node_ids ott_ids}, 
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
      when :tol_mrca, :tol_induced_subtree
        return false if @params == {} 
        # Both empty
        return false if ((@params[:node_ids] == []) || @params[:node_ids].nil?) && ((@params[:ott_ids] == []) || @params[:ott_ids].nil?)
      when :tol_subtree
        # Both provided
        return false if !@params[:node_id].nil? && !@params[:ott_id].nil?
        # Neither provided
        return false unless !@params[:node_id].nil? || !@params[:ott_id].nil? 
      when :tol_about
      else
        raise "Curious, #{@method} is not a method."
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

    def tol_about_url
     'about' 
    end

    def tol_mrca_url
     'mrca'
    end

    def tol_subtree_url
      'subtree' 
    end 

    def tol_induced_subtree_url
      'induced_subtree'
    end

  end
