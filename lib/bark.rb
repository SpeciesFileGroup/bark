# encoding: UTF-8

recent_ruby = RUBY_VERSION >= '2.1.0'
raise "IMPORTANT:  gem requires ruby >= 2.1.0" unless recent_ruby

require "bark/version"

require "json"
require "net/http"

require_relative 'bark/request'
require_relative 'bark/request/studies'
require_relative 'bark/request/tree_of_life'
require_relative 'bark/response'

class Bark
  # Code goes here...
end

class Bark::Error < StandardError

end
