# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "deco_model/version"

Gem::Specification.new do |s|
  s.name        = "deco_model"
  s.version     = DecoModel::VERSION
  s.authors     = ["Takuya Fujii"]
  s.email       = ["takuya327@gmail.com"]
  s.homepage    = 'https://github.com/takuya327/deco_mail'
  s.summary     = %q{A simple view helper for Rails 3}
  s.description = %q{A simple view helper for Rails 3. It's inspired by amatsuda/active_decorator}
  
  s.rubyforge_project = "deco_model"
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end