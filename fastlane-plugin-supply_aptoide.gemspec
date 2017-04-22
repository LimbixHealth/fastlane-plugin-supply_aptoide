# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/supply_aptoide/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-supply_aptoide'
  spec.version       = Fastlane::SupplyAptoide::VERSION
  spec.author        = "wschurman"
  spec.email         = "wschurman@limbix.com"

  spec.summary       = "Upload metadata, screenshots and binaries to Aptoide"
  spec.homepage      = "https://github.com/LimbixHealth/fastlane-plugin-supply_aptoide"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"] + %w(README.md LICENSE)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'json'

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'fastlane', '>= 2.28.3'
end
