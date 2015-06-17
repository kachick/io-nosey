require File.expand_path('../lib/io/nosey/version', __FILE__)

Gem::Specification.new do |gem|
  # specific

  gem.description   = %q{A tiny assistant for CUI operations.}
  gem.summary       = gem.description.dup
  gem.homepage      = 'http://kachick.github.com/io-nosey/'
  gem.license       = 'MIT'
  gem.name          = 'io-nosey'
  gem.version       = IO::Nosey::VERSION.dup

  gem.required_ruby_version = '>= 1.9.3'
  gem.add_dependency 'validation', '~> 0.0.7'
  gem.add_dependency 'optionalargument', '~> 0.1.0'
  gem.add_development_dependency 'rspec', '>= 3.3', '< 4'
  gem.add_development_dependency 'yard', '>= 0.8.7.6', '< 0.9'
  gem.add_development_dependency 'rake', '>= 10', '< 20'
  gem.add_development_dependency 'bundler', '>= 1.10', '< 2'

  # common

  gem.authors       = ['Kenichi Kamiya']
  gem.email         = ['kachick1+ruby@gmail.com']
  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features|declare)/})
  gem.require_paths = ['lib']

end
