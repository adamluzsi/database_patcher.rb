# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'database_patcher/version'

Gem::Specification.new do |spec|
  spec.name          = "database_patcher"
  spec.version       = DatabasePatcher::VERSION
  spec.authors       = ["Adam Luzsi"]
  spec.email         = ["adamluzsi@gmail.com"]

  spec.summary       = %q{Simple tool for managing database patches}
  spec.description   = %q{Simple tool for managing database patches}
  spec.homepage      = "https://github.com/adamluzsi/database_patcher.rb"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "dotenv"
  spec.add_development_dependency "pg"

  spec.add_dependency 'sequel'

end
