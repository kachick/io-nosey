# coding: us-ascii
$VERBOSE = true
require_relative 'helper'

module IO::Nosey::NoseyParker::RspecHelpers
  def np_input(input)
    @in << input
    @in.rewind
    @in
  end
end

RSpec.configure do |configuration|
  configuration.include IO::Nosey::NoseyParker::RspecHelpers
end

describe IO::Nosey::NoseyParker do

  before :each do
    @in = StringIO.new
    @out = StringIO.new
    @np = IO::Nosey::NoseyParker.new @in, @out
  end

  # Use after any inputs
  let :displayed do
    @out.string
  end

  describe "#ask" do

    before :each do
      @prompt = 'What your name?: '
      @answer = 'Foo 2 Bar'
    end

    let :answer do
      np_input @answer
      @np.ask @prompt
    end

    it "asks a question with the parametered prompt and returns the input" do
      expect(answer).to eq(@answer)
      expect(displayed).to eq(@prompt)
    end

    context "with a validator for the input" do
      context "the validator matches the input" do
        let :answer do
          np_input @answer
          @np.ask @prompt, input: /\A#{@answer}\z/
        end

        it "returns the input" do
          expect(answer).to eq(@answer)
        end
      end

      context "the validator does not match the first input but matches the second input" do
        let :answer do
          np_input "dummyFoo 2 Bardummy\nFoo 2 Bar"
          @np.ask @prompt, input: /\A#{@answer}\z/, error: 'Your input is invalid'
        end

        it "displays the parametered error message and returns the second input" do
          expect(answer).to eq(@answer)
          expect(displayed).to eq("What your name?: Your input is invalid\nWhat your name?: ")
        end
      end
    end

    context "with a parser for the input" do
      let :answer do
        np_input @answer
        @np.ask @prompt, parse: ->input{input.downcase}
      end

      it "returns a parsed value" do
        expect(answer).to eq(@answer.downcase)
      end

      context "with a validator for the returned value" do
        context "the validator matches the input" do
          let :answer do
            np_input @answer
            @np.ask @prompt, parse: ->input{input.downcase}, return: /./
          end

          it "returns a parsed value" do
            expect(answer).to eq(@answer.downcase)
          end
        end

        context "the validator does not match the first values but matches the second value" do
          let :answer do
            np_input "2\n3"
            @np.ask @prompt, parse: ->input{input.to_i}, 
                             return: 3..5,
                             error: 'Your input is invalid'
          end

          it "displays the parametered error message and returns the parsed value of the second input" do
            expect(answer).to eq(3)
            expect(displayed).to eq("What your name?: Your input is invalid\nWhat your name?: ")
          end
        end
      end
    end

    context "with a default input option" do
      before :each do
        @default = ':)'
      end

      context "with input" do
        it "returns the default option" do
          np_input @answer
          answer = @np.ask @prompt, default: @default
          expect(answer).to eq(@answer)
        end
      end

      context "without input(just entered the return key)" do
        it "returns the default option" do
          np_input "\n"
          answer = @np.ask @prompt, default: @default
          expect(answer).to eq(@default)
        end
      end
    end

  end



  describe "#agree?" do

    before :each do
      @prompt = 'Are you crazy? :)'
    end

    context "with affirmative inputs" do
      context 'when the input is "y"' do
        it "returns true" do
          np_input "y"
          ret = @np.agree? @prompt
          expect(ret).to be_true
        end
      end

      context 'when the input is "Y"' do
        it "returns true" do
          np_input "Y"
          ret = @np.agree? @prompt
          expect(ret).to be_true
        end
      end
    end

    context "with negative inputs" do
      context 'when the input is "n"' do
        it "returns false" do
          np_input "n"
          ret = @np.agree? @prompt
          expect(ret).to be_false
        end
      end

      context 'when the input is "N"' do
        it "returns false" do
          np_input "N"
          ret = @np.agree? @prompt
          expect(ret).to be_false
        end
      end
    end

  end



  describe "#choose" do

    before :each do
      @prompt = 'Choose an index: '
      @obj = Object.new # Don't use String for example.
                        # That returns other instanse via Hash key.
      @choices = {
        5      => '5 is a Integer',
        @obj   => '"obj" is a Object',
        :FIVE  => ':FIVE is a Symbol'
      }
    end

    context "when choose an index" do
      it "returns the relative value if selected 1" do
        np_input 1
        ret = @np.choose @prompt, @choices
        expect(ret).to equal(5)
      end

      it "returns the relative value if selected 2" do
        np_input 2
        ret = @np.choose @prompt, @choices
        expect(ret).to equal(@obj)
      end

      it "returns the relative value if selected 3" do
        np_input 3
        ret = @np.choose @prompt, @choices
        expect(ret).to equal(:FIVE)
      end
    end

  end

end