# Copyright (C) 2011  Kenichi Kamiya

require 'forwardable'
require 'validation'
require_relative 'nosey/version'
require_relative 'nosey/noseyparker'

class IO

  # @author Kenichi Kamiya
  module Nosey
    extend Forwardable
    private_class_method(*Forwardable.instance_methods(false))
    include Validation
    
    NOSEY_PARKER = NoseyParker.new
    private_constant :NoseyParker, :NOSEY_PARKER

    module_function
    def_delegators :NOSEY_PARKER, :ask, :agree?, :choose
  end

end
