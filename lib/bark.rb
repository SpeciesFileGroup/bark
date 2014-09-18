# encoding: UTF-8

recent_ruby = RUBY_VERSION >= '2.1.0'
raise "IMPORTANT:  gem requires ruby >= 2.1.0" unless recent_ruby

require "bark/version"

require "json"
require "net/http"

require_relative 'bark/request'
require_relative 'bark/request/studies'
require_relative 'bark/request/tree_of_life'
require_relative 'bark/request/graph_of_life'
require_relative 'bark/request/tnrs'
require_relative 'bark/request/taxonomy'

require_relative 'bark/response'

class Bark

  def self.request_class(method)
    method = method.to_s
    return Bark::Request::TreeOfLife  if method =~ /^tol_/ 
    return Bark::Request::Tnrs        if method =~ /^tnrs_/ 
    return Bark::Request::GraphOfLife if method =~ /^gol_/ 
    return Bark::Request::Taxonomy    if method =~ /^taxonomy_/ 
    return Bark::Request::Studies     if method =~ /^studies_|^get_study/ 
    return false
  end

  def self.method_missing(meth, *args, &block)
    if klass = self.request_class(meth)
       params = args
       params = {} if params == []
       request = klass.new(method: meth, params: params, &block)
       Bark::Response.new(request: request).result
    else
      super
    end
  end

   #def self.tol_about(params: {}) 
   #end

   #def self.tol_mrca(params: {}) 
   #end

   #def self.tol_subtree(params: {}) 
   #end

   #def self.tol_induced_tree(params: {}) 
   #end

   #def self.gol_about(params: {}) 
   #end

   #def self.gol_source_tree(params: {}) 
   #end

   #def self.gol_node_info(params: {}) 
   #end

   #def self.tnrs_match_names(params: {}) 
   #end

   #def self.tnrs_contexts(params: {}) 
   #end

   #def self.tnrs_infer_context(params: {}) 
   #end

   #def self.taxonomy_about(params: {}) 
   #end

   #def self.taxonomy_lica(params: {}) 
   #end

   #def self.taxonomy_subtree(params: {}) 
   #end

   #def self.taxonomy_taxon(params: {}) 
   #end

   #def self.studies_find_studies(params: {})
   #end

   #def self.studies_find_trees(params: {}) 
   #end

   #def self.studies_properties(params: {}) 
   #end

   #def self.get_study(params: {}) 
   #end

   #def self.get_study_tree(params: {}) 
   #end

end

class Bark::Error < StandardError

end
