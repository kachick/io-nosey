# coding: us-ascii
# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

group :development, :test do
  gem 'rake', '~> 13.0.6'
  gem 'irb', '~> 1.6.2'
  gem 'irb-power_assert', '0.1.1'
end

group :development do
  gem 'yard', '~> 0.9.28', require: false
  # https://github.com/rubocop/rubocop/pull/10796
  gem 'rubocop', '~> 1.50.2', require: false
  gem 'rubocop-rake', '~> 0.6.0', require: false
end

group :test do
  gem 'rspec', '~> 3.12.0'
  gem 'rspec-matchers-power_assert_matchers', '0.2.0'
  gem 'warning', '~> 1.3.0'
end
