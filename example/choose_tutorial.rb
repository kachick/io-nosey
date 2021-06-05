# coding: us-ascii
# frozen_string_literal: true

require_relative 'helper'

# choose one
choice =  \
    choose 'Which Five do you like?: ',  5     => '5 is a Integer',
                                      'five' => '"five" is a String',
                                      :FIVE  => ':FIVE is a Symbol'
show choice
