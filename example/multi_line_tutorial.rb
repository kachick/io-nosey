# coding: us-ascii
require_relative 'helper'

# multi line mode
name = ask 'Write you poem and exit ctrl+d :) ', multi_line: true
show name