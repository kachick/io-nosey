# coding: us-ascii
# frozen_string_literal: true

lib_name = 'io-nosey'

require_relative './lib/io/nosey/version'
repository_url = "https://github.com/kachick/#{lib_name}"

Gem::Specification.new do |gem|
  gem.summary       = %q{Tiny assistant for CUI operations}
  gem.description   = <<-'DESCRIPTION'
    Tiny assistant for CUI operations
  DESCRIPTION
  gem.homepage      = repository_url
  gem.license       = 'MIT'
  gem.name          = lib_name
  gem.version       = IO::Nosey::VERSION

  gem.metadata = {
    'documentation_uri' => 'https://kachick.github.io/io-nosey/',
    'homepage_uri'      => repository_url,
    'source_code_uri'   => repository_url,
    'bug_tracker_uri'   => "#{repository_url}/issues"
  }

  gem.required_ruby_version = Gem::Requirement.new('>= 2.7.0')

  gem.add_runtime_dependency 'io-console'
  gem.add_runtime_dependency 'eqq', '>= 0.0.5', '< 0.1.0'
  gem.add_runtime_dependency 'optionalargument', '>= 0.5.1', '< 0.6.0'

  # common

  gem.authors       = ['Kenichi Kamiya']
  gem.email         = ['kachick1+ruby@gmail.com']
  git_managed_files = `git ls-files`.lines.map(&:chomp)
  might_be_parsing_by_tool_as_dependabot = git_managed_files.empty?
  base_files = Dir['README*', '*LICENSE*',  'lib/**/*', 'sig/**/*'].uniq
  files = might_be_parsing_by_tool_as_dependabot ? base_files : (base_files & git_managed_files)

  unless might_be_parsing_by_tool_as_dependabot
    if files.grep(%r!\A(?:lib|sig)/!).size < 2
      raise "obvious mistaken in packaging files, looks shortage: #{files.inspect}"
    end
  end

  gem.files         = files
  gem.require_paths = ['lib']
end
