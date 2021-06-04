# coding: us-ascii

require_relative 'helper'

# with input validation
name = ask 'What\'s your name?("first_name last_name"): ', input: /\A\w+ \w+\z/
show name
