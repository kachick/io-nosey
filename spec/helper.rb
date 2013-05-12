# coding: us-ascii
require 'rspec'
require 'stringio'

$VERBOSE = true

require_relative '../lib/io/nosey'

module IO::Nosey::NoseyParker::RspecHelpers
  def np_input(input)
    @in << input
    @in.rewind
    @in
  end
end

RSpec.configure do |configuration|
  configuration.include IO::Nosey::NoseyParker::RspecHelpers
end