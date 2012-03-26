# -*- encoding: utf-8 -*-
require File.expand_path('../lib/big_ml/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Vicent Gozalbes", "Felipe Talavera"]
  gem.email         = ["vigosan@gmail.com", "felipe.talavera@gmail.com"]
  gem.description   = %q{A Ruby wrapper for the BigML REST API}
  gem.summary       = %q{A Ruby wrapper for the BigML REST API}
  gem.homepage      = "https://bigml.com"

  gem.add_development_dependency "rspec"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "big_ml"
  gem.require_paths = ["lib"]
  gem.version       = BigML::VERSION
end
