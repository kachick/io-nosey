$VERBOSE = true
require File.dirname(__FILE__) + '/test_helper.rb'

class TestIONosey < Test::Unit::TestCase
  include IO::Nosey
end
