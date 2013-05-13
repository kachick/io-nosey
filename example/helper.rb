# coding: us-ascii
$VERBOSE = true

require_relative '../lib/io/nosey'

include IO::Nosey

def show(obj)
  puts "This script understands your input: #{obj.inspect}"
end