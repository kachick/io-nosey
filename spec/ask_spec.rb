# coding: us-ascii

RSpec.describe IO::Nosey::NoseyParker do

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

    context "with truthy multi_line option" do
      it "returns the origin lines without chomp" do
        np_input "1\n2\n3\n"
        answer = @np.ask @prompt, multi_line: true
        expect(answer).to eq("1\n2\n3\n")
      end
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

end
