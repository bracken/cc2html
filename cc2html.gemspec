# -*- encoding: utf-8 -*-
require File.expand_path('../lib/cc2html/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Bracken Mosbacker"]
  gem.description   = %q{Converts an IMS Common Cartridge package to a self-contained web site or epub}
  gem.summary       = %q{Converts an IMS Common Cartridge package to a self-contained web site or epub}
  gem.homepage      = "https://github.com/bracken/cc2html"

  gem.add_runtime_dependency "rubyzip"
  gem.add_runtime_dependency "happymapper"
  gem.add_runtime_dependency "builder"
  gem.add_runtime_dependency "thor"
  gem.add_runtime_dependency "nokogiri"
  gem.add_runtime_dependency "rdiscount"

  gem.add_development_dependency "rake"
  gem.add_development_dependency "minitest"
  gem.add_development_dependency "guard"
  gem.add_development_dependency "guard-bundler"
  gem.add_development_dependency "guard-minitest"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "cc2html"
  gem.require_paths = ["lib"]
  gem.version       = CC2HTML::VERSION
  gem.extra_rdoc_files = %W(LICENSE)
  gem.license = 'MIT'
end
