# coding: us-ascii
require_relative 'helper'

# with input validation
name = ask 'What\'s your name?("firstname lastname"): ', input: /\A\w+ \w+\z/
show name