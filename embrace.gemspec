# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'embrace/version'

Gem::Specification.new do |spec|
  spec.name          = "embrace"
  spec.version       = Embrace::VERSION
  spec.authors       = ["John Carney"]
  spec.email         = ["john@carney.id.au"]

  spec.summary       = %q{Strings are nice. Give 'em a hug.}
  spec.description   = %q{Simple library for enclosing text in brackets, or anything else that takes your fancy.}
  spec.homepage      = "https://github.com/johncarney/embrace"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake",    "~> 10.0"
  spec.add_development_dependency "rspec",   "~> 3.0"
end
