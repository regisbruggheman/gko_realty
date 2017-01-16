# coding: utf-8

$:.push File.expand_path('../lib', __FILE__)
require 'gko_realty/version'

Gem::Specification.new do |s|
  s.name         = "gko_realty"
  s.version      = GkoRealty::VERSION
  s.authors      = ["Regis Bruggheman"]
  s.email        = "regis@joufdesign.com"
  s.homepage     = "http://github.com/jdfdesign"
  s.summary      = "Realty plugin"
  s.description  = "Realty plugin"
  s.files        = Dir['{app,config,lib,public}/**/*']
  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'
end