# coding: us-ascii
# frozen_string_literal: true

# Copyright (C) 2011  Kenichi Kamiya

require 'forwardable'
require 'eqq'
require 'validation'
require 'optionalargument'
require_relative 'nosey/version'
require_relative 'nosey/noseyparker'

class IO
  module Nosey
    extend Forwardable
    private_class_method(*Forwardable.instance_methods(false))

    NOSEY_PARKER = NoseyParker.new

    def_delegators :NOSEY_PARKER, :ask, :agree?, :choose
  end
end
