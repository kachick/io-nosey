# coding: us-ascii
# frozen_string_literal: true

class IO
  module Nosey
    class Parker
      class Error < StandardError; end
      class InvalidInputError < Error; end

      def self.adjustable?(object)
        case object
        when Proc
          object.arity == 1
        else
          if object.respond_to?(:to_proc)
            object.to_proc.arity == 1
          else
            false
          end
        end
      end

      # @param input [IO, StringIO]
      # @param output [IO, StringIO]
      def initialize(input: $stdin, output: $stdout)
        @input, @output = input, output
      end

      AskOpts = OptionalArgument.define {
        opt(:input, condition: Regexp)
        opt(:parse, aliases: [:parser], condition: ->v { Parker.adjustable?(v) })
        opt(:return, condition: ->v { Eqq.valid?(v) })
        opt(:default, condition: CAN(:to_str))
        opt(:echo, condition: BOOLEAN(), default: true)
        opt(:error, condition: CAN(:to_str), default: 'Your answer is invalid.')
        opt(:multi_line, condition: BOOLEAN(), default: false)
      }

      # @param prompt [String]
      def ask(prompt, **kw_args)
        opts = AskOpts.parse(kw_args)

        @output.print(prompt)

        if opts.default?
          @output.print("(default: #{opts.default})")
        end

        if opts.multi_line
          if opts.echo
            input = @input.read
          else
            input = @input.noecho(&:read)
            @output.puts
          end
        else
          if opts.echo
            input = @input.gets.chomp
          else
            input = @input.noecho(&:gets).chomp
            @output.puts
          end
        end

        if input.empty? && opts.default?
          input = opts.default
        end

        if opts.input? && !valid?(opts.input, input)
          raise InvalidInputError, opts.error
        end

        if opts.parse?
          input = opts.parse.call(input)
        end

        if opts.return? && !valid?(opts.return, input)
          raise InvalidInputError, opts.error
        end

        input
      rescue InvalidInputError
        @output.puts $!.message unless $!.message.empty?
        retry
      end

      # @param prompt [String]
      def agree?(prompt)
        @output.print("#{prompt} [y or n]")

        input = @input.getch
        @output.print("\n")

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
      # @param choices [Hash{Object => String}] key: value, value: description
      # @return a member of choices
      def choose(prompt, choices)
        raise ArgumentError if choices.empty?

        @output.puts prompt
        @output.puts [:index, :value, :description].join("\t")

        pairs = {}
        index = 1
        choices.each_pair do |value, description|
          @output.puts [index, value, description].join("\t")
          pairs[index] = value
          index += 1
        end

        number = ask('Select index:',
                     input: /\A(\d+)\z/,
                     parse: ->v { Integer(v) },
                     return: Eqq.AND(Integer, 1..(index - 1)))

        pairs[number]
      end

      private

      # @param [Proc, Method, #===] pattern
      # @param [Object] value
      def valid?(pattern, value)
        !!(
          case pattern
          when Proc
            instance_exec(value, &pattern)
          when Method
            pattern.call(value)
          else
            pattern === value
          end
        )
      end
    end
  end
end
