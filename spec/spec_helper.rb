# require 'coveralls'
# Coveralls.wear!

# These are development helpers.
require 'awesome_print'
require 'byebug'

# These are required to run tests.
require 'bark' 
require 'hashie'
require 'shared_tests_helper'
require 'shared_tests'

RSpec.configure do |config|
  # Use color in STDOUT
  config.color = true

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  # Use the specified formatter
  config.formatter = :documentation # :progress, :html, :textmate
end
