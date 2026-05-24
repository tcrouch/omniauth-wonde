# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "omniauth/wonde/version"

Gem::Specification.new do |spec|
  spec.name = "omniauth-wonde"
  spec.version = OmniAuth::Wonde::VERSION
  spec.authors = ["Tom Crouch"]
  spec.email = ["tom.crouch@gmail.com"]

  spec.summary = "OmniAuth strategy for Wonde"
  spec.homepage = "https://github.com/tcrouch/omniauth-wonde"
  spec.license = "MIT"

  spec.files = Dir["lib/**/*", "*.gemspec", "LICENSE*", "README*"]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 3.0.0"

  spec.add_runtime_dependency "omniauth-oauth2"

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "standard", "~> 1.54"
end
