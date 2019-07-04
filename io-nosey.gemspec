# coding: us-ascii

lib_name = 'io-nosey'.freeze
require "./lib/io/nosey/version"

Gem::Specification.new do |gem|
  # specific

  gem.description   = %q{A tiny assistant for CUI operations.}
  gem.summary       = gem.description.dup
  gem.homepage      = "http://kachick.github.com/#{lib_name}"
  gem.license       = 'MIT'
  gem.name          = lib_name.dup
  gem.version       = IO::Nosey::VERSION.dup

  gem.add_dependency 'validation', '~> 0.0.7'
  gem.add_dependency 'optionalargument', '~> 0.1.0'
  gem.add_development_dependency 'rspec', '>= 3.8', '< 4'
  gem.add_development_dependency 'yard', '>= 0.9.20', '< 2'
  gem.add_development_dependency 'rake', '>= 10', '< 20'
  gem.add_development_dependency 'bundler', '>= 2', '< 3'

  if RUBY_ENGINE == 'rbx'
    gem.add_dependency 'rubysl', '~> 2.1'
  end

  # common

  gem.authors       = ['Kenichi Kamiya']
  gem.email         = ['kachick1+ruby@gmail.com']
  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features|declare)/})
  gem.require_paths = ['lib']

end
