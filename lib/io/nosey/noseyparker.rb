require 'forwardable'
require 'io/console'
require 'validation'

class IO; module Nosey 

  class NoseyParker
  
    extend Forwardable
    private_class_method(*Forwardable.instance_methods(false))
    include Validation
    include Validation::Condition
    include Validation::Adjustment
    
    class InvalidInputError < InvalidError; end

    OPTIONAL_KEYS = [:input, :default, :parse, :return, :echo, :error].freeze
    DEFAULT_OPTIONS = {echo: true}.freeze

    def initialize(input=$stdin, output=$stdout)
      @input, @output = input, output
    end

    def_delegators :@input, :gets, :getc, :getch, :noecho, :raw, :winsize
    def_delegators :@output,:print, :puts, :flush, :<<    
    
    # @param [String] prompt
    # @param [Hash] options
    def ask(prompt, options=DEFAULT_OPTIONS)
      options = DEFAULT_OPTIONS.merge options
      unless valid_options? options
        raise ArgumentError, 'including invalid options' 
      end
      
      print prompt
      
      error_message = 
        (
         if options.has_key?(:error)
           options[:error]
         else
           'We are not satisfied with your answer.'
         end
         )

      if options.has_key? :default
        print "(default: #{options[:default]})"
      end
      
      if options[:echo]
        input = gets.chomp
      else
        input = noecho(&:gets).chomp
        puts
      end

      if input.empty? and options.has_key?(:default)
        input = options[:default]
      end
      
      if options.has_key?(:input) and !_valid?(options[:input], input)
        raise InvalidInputError, error_message
      end
      
      if options.has_key?(:parse)
        input = options[:parse].call input
      end
      
      if options.has_key?(:return) and !_valid?(options[:return], input)
        raise InvalidInputError, error_message
      end
      
      input
    rescue InvalidError
      puts $!.message unless $!.message.empty?
      retry
    end
    
    # @param [String] prompt
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
    
    # @param [String] prompt
    # @param [Hash] choices {value => description}
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
    
    def valid_options?(options)
      raise unless (options.keys - OPTIONAL_KEYS).empty?
      raise if options.has_key?(:parse) and !Validation.adjustable?(options[:parse])
      raise if options.has_key?(:input) and !options[:input].kind_of?(Regexp)
      raise if options.has_key?(:return) and !conditionable?(options[:return])
      raise if options.has_key?(:default) and !options[:default].respond_to?(:to_str)
    rescue
      $stderr.puts "WARN: Faced Exception: #{$!.inspect}"
      false
    else
      true
    end
    
    def valid_choices?(choices)
      choices.keys.length >= 1
    end

  end
  
end; end