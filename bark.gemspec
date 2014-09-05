# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bark/version'

Gem::Specification.new do |spec|
  spec.name          = "bark"
  spec.version       = Bark::VERSION
  spec.authors       = ["Matt Yoder"]
  spec.email         = ["diapriid@gmail.com"]
  spec.summary       = %q{A Ruby wrapper on the Open Tree API.}
  spec.description   = %q{A wrapper on the Open Tree API, instantiated in anticipation of the OT hackathon in September, 2014.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  
  spec.required_ruby_version = '~> 2.1'

  spec.add_runtime_dependency 'json', '~> 1.8'

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "rspec", '~> 3.1'
  spec.add_development_dependency "awesome_print"

end
