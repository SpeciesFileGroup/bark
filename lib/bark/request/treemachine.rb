class Bark

  # Target API https://github.com/OpenTreeOfLife/opentree/wiki/Open-Tree-of-Life-APIs
 
  class Request
    BASE_URL = 'http://api.opentreeoflife.org/'
    API_VERSION = 'v1'  
    INTERFACE = 'httpquery.ashx?'
    FORMAT = 'json'
    SEARCH_BASE = [BASE_URL, API_VERSION, INTERFACE].join("/") 

    METHODS = { 
      getSyntheticTree: %w{treeID format maxDepth subtreeNodeID},
      getDraftTreeSubtreeForNodes: %w{title lname volume edition year subject language collectionid}, 
      getSynthesisSourceList: %w{creatorid}, 
      contextQueryForNames: %w{creatorid},  
      getContextForNames: %w{},        # no params
      getContextsJSON: %w{type value}, 
      autocompleteBoxQuery: %w{itemid pages oc parts}, 
    }

    REQUIRED_PARAMS = {
      'name' => [:AuthorSearch, :NameSearch],
      'creatorid' => [:GetAuthorParts, :GetAuthorTitles],
      'type' => [:GetItemByIdentifier, :GetPartByIdentifier, :GetTitleByIdentifier],
      'value' => [:GetItemByIdentifier, :GetPartByIdentifier, :GetTitleByIdentifier],
      'itemid' => [:GetItemMetadata, :GetItemPages, :GetItemParts],
      'pageid' => [:GetPageMetadata, :GetPageNames, :GetPageOcrText, :GetPartBibTeX],
      'partid'  => [:GetPartBibTeX, :GetPartEndNote, :GetPartMetadata, :GetPartNames],
      'subject' => [:GetSubjectParts, :GetSubjectTitles, :SubjectSearch],
      'titleid' => [:GetTitleBibTex, :GetTitleEndNote, :GetTitleItems, :GetTitleMetadata],
      'title' => [:TitleSearchSimple] 
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
      return true if METHODS[@method] == []
      @params.keys - METHODS[@method] == []
    end

    def has_required_params?
      return false if @method.nil?
      return true if METHODS_REQUIRED_PARAMS[@method].nil?
      METHODS_REQUIRED_PARAMS[@method].select{|v| !@params.keys.include?(v)} == []
    end

    def valid?
      raise API_KEY_MESSAGE if @api_key.nil?
      raise "Method #{@method} not recognized." if @method && !RubyBHL::Request::METHODS.keys.include?(@method)
      raise "Format #{@format} not recognized." if @format && !%w{json xml}.include?(@format)

      !@method.nil? && !@format.nil? && params_are_supported? && has_required_params?
    end

    private 

    def build_url
      @search_url = SEARCH_BASE + 'op=' + @method.to_s +
        @params.keys.sort{|a,b| a.to_s <=> b.to_s}.collect{|k| "&#{k}=#{@params[k].to_s.gsub(/\s/, "+")}"}.join +
      '&format=' + @format + '&apikey=' + @api_key
    end

  end
end
