# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ar2gostruct/version'

Gem::Specification.new do |spec|
  spec.name          = "ar2gostruct"
  spec.version       = Ar2gostruct::VERSION
  spec.authors       = ["Tatsuo Kaniwa"]
  spec.email         = ["tatsuo@kaniwa.biz"]
  spec.description   = %q{Generate Go Struct from activerecord models}
  spec.summary       = %q{Generate Go Struct from activerecord models}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.files         += Dir.glob("{lib}/**/*")
  spec.executables << 'ar2gostruct'
  spec.require_paths  = ["lib"]
  spec.test_files     = `git ls-files -- {spec}/*`.split("\n")

  spec.extra_rdoc_files = ["README.md"]
  spec.rdoc_options     = ["--line-numbers", "--inline-source", "--title", "ar2gostruct"]

  spec.add_dependency "rake", ">= 0.8.7"
  spec.add_dependency "activerecord", ">= 2.3.0"
  spec.add_dependency "activesupport", ">= 2.3.0"
  spec.add_development_dependency "rspec"
end
