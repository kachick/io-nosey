# coding: us-ascii
# frozen_string_literal: true

require 'rspec'
require 'rspec/matchers/power_assert_matchers'
require 'stringio'
require 'warning'

require_relative '../lib/io/nosey'

module ParkerRspecHelpers
  def np_input(input)
    @in << input
    @in.rewind
    @in
  end
end

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.warnings = true
  config.raise_on_warning = true

  config.expect_with(:rspec) do |c|
    c.syntax = :expect
  end

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  config.include ParkerRspecHelpers
end

Warning[:deprecated] = true
Warning[:experimental] = true

Gem.path.each do |path|
  Warning.ignore(//, path)
end

Warning.process do |_warning|
  :raise
end
