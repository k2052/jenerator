#!/usr/bin/env gem build
# encoding: utf-8

Gem::Specification.new do |s|
  s.name                      = "jenerator"
  s.rubyforge_project         = "jenerator"
  s.authors                   = ["Ken Erickson"]
  s.email                     = "bookworm.productions@gmail.com"
  s.summary                   = "Joomla Generators"
  s.homepage                  = "http://github.com/bookworm/jenerator"
  s.description               = "Generators for easily creating dummy/base Joomla! extensions"
  s.required_rubygems_version = ">= 1.3.6"
  s.version                   = '0.0.1'
  s.date                      = Time.now.strftime("%Y-%m-%d")

  s.extra_rdoc_files = Dir["*.rdoc"]
  s.files            = `git ls-files`.split("\n") | Dir.glob("{lib}/**/*")
  s.test_files       = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables      = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths    = ["lib"]
  s.rdoc_options     = ["--charset=UTF-8"]

  s.add_dependency("bundler", "~> 1.0")
  s.add_dependency("thor")
  s.add_dependency("ffaker")
  s.add_dependency("active_support")
end