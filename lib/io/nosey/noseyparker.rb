require 'forwardable'
require 'io/console'

class IO; module Nosey 

  # @author Kenichi Kamiya
  class NoseyParker
    extend Forwardable
    
    class InvalidInputError < RuntimeError
    end
    
    private_class_method(*Forwardable.instance_methods(false))
    private_constant :InvalidInputError

    def initialize(input=$stdin, output=$stdout)
      @input, @output = input, output
    end

    def_delegators :@input, :gets, :getc, :getch, :noecho, :raw, :winsize
    def_delegators :@output,:print, :puts, :flush, :<<    
    
    def ask(prompt='?', regexp=nil, &block)
      ask_oneline(prompt, regexp, block){gets.chomp}
    end
    
    def secret(prompt='(hidden)?', regexp=nil, &block)
      ask_oneline(prompt, regexp, block){noecho(&:gets).chomp}
    end
    
    alias_method :password, :secret

    def agree?(message)
      print "#{message}:y/n?"

      input = getch
      print "\n"
      
      case input
      when 'n', 'N'
        false
      when 'y', 'Y'
        true
      else
        invalid
      end
      
    rescue InvalidInputError
      puts $!.message unless $!.message.empty?
      retry
    end

    def choose(message, *choices)
      puts message
      
      first = 1
      
      choices.each_with_index do |v, i|
        puts "#{i + first}.\t#{v}"
      end
      
      ask 'Select index?', /\A(\d+)\z/ do |_, m|
        view_num = m[1].to_i
        index = view_num - first
        
        if (first..choices.length).include? view_num
          choices[index]
        else
          invalid 'Out of Range.'
        end
      end
    end
    
    private

    def invalid(cause='We are not satisfied with your answer.')
      raise InvalidInputError, cause
    end
    
    alias_method :error, :invalid
    
    def ask_oneline(prompt, regexp=nil, handling=nil)
      raise ArgumentError unless block_given?
      
      print prompt
      
      input = yield
      
      case regexp
      when Regexp
        if matched = regexp.match(input)
          if handling
            instance_exec input, matched, &handling
          else
            input
          end
        else
          invalid
        end
      when nil
        if handling
          instance_exec input, &handling
        else
          input
        end
      else
        raise ArgumentError
      end
      
    rescue InvalidInputError
      puts $!.message unless $!.message.empty?
      retry
    end
  end
  
end; end