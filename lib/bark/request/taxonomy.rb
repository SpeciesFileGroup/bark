class Bark::Request::Taxonomy < Bark::Request

    API_VERSION = 'v2'  
    SEARCH_BASE = [Bark::Request::BASE_URL, API_VERSION, 'taxonomy'].join("/")  

    # Method: {parameters} 
    METHODS = { 
      taxonomy_about: %i{},
      taxonomy_lica: %i{},
      taxonomy_subtree: %i{}, 
      taxonomy_taxon: %i{}, 
    }

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
      when :taxonomy_about
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

    def taxonomy_about_url
      'about' 
    end

    def taxonomy_lica_url
      'lica'
    end

    def taxonomy_subtree_url 
      'subtree' 
    end 

    def taxonomy_taxon_url 
      'taxon'
    end

  end
