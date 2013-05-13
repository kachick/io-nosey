# coding: us-ascii
require_relative 'helper'

# handle return value
age = ask 'How old are you?: ', input:   /\A(\d+)\z/,
                              parse:   ->s{Integer s},
                              return: 10..100
show age