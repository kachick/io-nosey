# coding: us-ascii
# frozen_string_literal: true

# Copyright (C) 2011  Kenichi Kamiya

require 'eqq'
require 'optionalargument'

class IO
  module Nosey
    def self.parker(**kw_args, &block)
      Parker.new(**kw_args).instance_exec(&block)
    end
  end
end

require_relative 'nosey/parker'
require_relative 'nosey/version'
