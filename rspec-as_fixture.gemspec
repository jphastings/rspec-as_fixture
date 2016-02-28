# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspec/as_fixture/version'

Gem::Specification.new do |spec|
  spec.name          = "rspec-as_fixture"
  spec.version       = Rspec::AsFixture::VERSION
  spec.authors       = ["JP Hastings-Spital"]
  spec.email         = ["jphastings@gmail.com"]

  spec.summary       = %q{Load fixture files as properties for rspec tests}
  spec.description   = %q{Fixture files for RSpec tests}
  spec.homepage      = "https://github.com/jphastings/rspec-as_fixture"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rspec", "~> 3.4"

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
