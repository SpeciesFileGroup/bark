class Bark::Request::Studies < Bark::Request

  API_VERSION = 'v2'  
  FORMAT = 'json'
  SEARCH_BASE = [Bark::Request::BASE_URL, API_VERSION].join("/") 

  # Studies methods are slightly different because of the API differences
  METHODS = { 
    studies_find_studies: %i{property value exact verbose},
    studies_find_trees: %i{property value exact verbose},
    studies_properties: %i{}, 
    get_study: %i{study_id},               # GET, not post
    get_study_tree: %i{study_id tree_id},  # GET, not post
  }

  REQUIRED_PARAMS = {
    study_id: %i{study get_study_tree},
    tree_id:  %i{get_study_tree},
    property: %i{studies_find_trees},
    value:  %i{studies_find_trees}
  }

  mrp = {}

  REQUIRED_PARAMS.each do |k,v|
    v.each do |m|
      mrp[m].push(k) if mrp[m] 
      mrp[m] ||= [k]
    end
  end

  METHODS_REQUIRED_PARAMS = mrp

  # Only studies takes a method parameter
  attr_accessor :method

  def initialize(method: :study_list, params: {})
    assign_options(method: method, params: params)
    build_uri if valid?
  end

  def assign_options(method: method, params: params)
    @method = method.to_sym
    @params = params
  end

  def valid?
    raise "Method #{@method} not recognized." if @method && !Bark::Request::Studies::METHODS.keys.include?(@method)
    !@method.nil? && params_are_supported? && has_required_params?
  end

  def json_payload
    JSON.generate(@params)
  end

  private 

  # TODO: this doesn't feel right
  def build_uri
    @uri = URI( SEARCH_BASE +  send("#{@method}_url") )
  end

  def studies_find_studies_url
    '/studies/find_studies' 
  end

  def studies_find_trees_url
    '/studies/find_trees' 
  end

  def studies_properties_url
    '/studies/properties' 
  end

  def get_study_tree_url
    "/study/#{@params[:study_id]}/tree/#{@params[:tree_id]}"
  end

  def get_study_url
    '/study/' + @params[:study_id].to_s
  end 
end
