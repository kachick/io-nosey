# coding: us-ascii
# frozen_string_literal: true

require_relative 'helper'

# multi line mode
name = ask 'Write you poem and exit ctrl+d :) ', multi_line: true
show name
