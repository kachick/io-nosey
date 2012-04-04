$VERBOSE = true
require_relative 'test_helper'

class TestIONosey < Test::Unit::TestCase
  class Sth
    include IO::Nosey
  end
  
  def test_respond
    assert_equal true, Sth.new.respond_to?(:agree?, true)
  end
end
