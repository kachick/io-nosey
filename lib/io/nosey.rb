# IO::Nosey
#   Copyright (C) 2011  Kenichi Kamiya

require 'forwardable'
require_relative 'nosey/version'
require_relative 'nosey/noseyparker'

class IO

  # @author Kenichi Kamiya
  module Nosey   
    extend Forwardable
    private_class_method(*Forwardable.instance_methods(false))
    
    NOSEY_PARKER = NoseyParker.new
    private_constant :NoseyParker, :NOSEY_PARKER

    def_delegators :NOSEY_PARKER, :ask, :secret, :password, :agree?, :choose
    
    module_function :ask, :secret, :password, :agree?, :choose
  end

end
