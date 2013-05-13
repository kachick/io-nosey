# coding: us-ascii

require 'forwardable'
require 'io/console'
require 'validation'
require 'optionalargument'

class IO; module Nosey 

  class NoseyParker
  
    extend Forwardable
    private_class_method(*Forwardable.instance_methods(false))
    include Validation
    include Validation::Condition
    include Validation::Adjustment
    
    class InvalidInputError < InvalidError; end

    # @param input [IO, StringIO]
    # @param output [IO, StringIO]
    def initialize(input=$stdin, output=$stdout)
      @input, @output = input, output
    end

    def_delegators :@input, :gets, :getc, :getch, :noecho, :raw, :winsize
    def_delegators :@output,:print, :puts, :flush, :<<    

    AskOpts = OptionalArgument.define {
      opt :input, condition: Regexp
      opt :parse, aliases: [:parser], condition: ->v{adjustable? v}
      opt :return, condition: ->v{conditionable? v}
      opt :default, condition: CAN(:to_str)
      opt :echo, condition: BOOLEAN?, default: true
      opt :error, condition: CAN(:to_str), default: 'Your answer is invalid.'
    }

    # @param prompt [String]
    # @param options [Hash]
    # @option options [Regexp] :input
    # @option options [Proc] :parse (also :parser)
    # @option options [Proc, Method, #===] :return
    # @option options [String, #to_str] :default
    # @option options [Boolean] :echo
    # @option options [String, #to_str] :error
    def ask(prompt, options={})
      opts = AskOpts.parse options
      
      print prompt

      if opts.default?
        print "(default: #{opts.default})"
      end
      
      if opts.echo?
        input = gets.chomp
      else
        input = noecho(&:gets).chomp
        puts
      end

      if input.empty? and opts.default?
        input = opts.default
      end
      
      if opts.input? and !_valid?(opts.input, input)
        raise InvalidInputError, opts.error
      end
      
      if opts.parse?
        input = opts.parse.call input
      end
      
      if opts.return? and !_valid?(opts.return, input)
        raise InvalidInputError, opts.error
      end
      
      input
    rescue InvalidError
      puts $!.message unless $!.message.empty?
      retry
    end
    
    # @param prompt [String]
    def agree?(prompt)
      print "#{prompt} [y or n]"

      input = getch
      print "\n"
      
      case input
      when 'n', 'N'
        false
      when 'y', 'Y'
        true
      else
        raise InvalidInputError
      end
    rescue InvalidInputError
      retry
    end
    
    # @param prompt [String]
    # @param choices [Hash, #each_pair] key: value, value: description
    # @return a member of choices
    def choose(prompt, choices)
      raise ArgumentError unless valid_choices? choices
      puts prompt
      puts [:index, :value, :description].join("\t")
      
      pairs = {}
      index = 1
      choices.each_pair do |value, description|
        puts [index, value, description].join("\t")
        pairs[index] = value
        index += 1
      end
      
      number = ask 'Select index:',
        input: /\A(\d+)\z/,
        parse: PARSE(Integer),
        return: AND(Integer, 1..(index - 1))
      
      pairs[number]
    end
    
    private

    def valid_choices?(choices)
      choices.keys.length >= 1
    end

  end
  
end; end