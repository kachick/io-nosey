# coding: us-ascii
# frozen_string_literal: true

require_relative 'helper'

# with default value
answer = ask "What's your favorite?: ", default: 'ruby'
show answer
