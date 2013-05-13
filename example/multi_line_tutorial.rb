# coding: us-ascii
$VERBOSE = true

# setup
require_relative '../lib/io/nosey'

include IO::Nosey

def show(obj)
  puts "This script understands your input: #{obj.inspect}"
end

# multi line mode
name = ask 'Write you poem and exit ctrl+d :) ', multi_line: true
show name