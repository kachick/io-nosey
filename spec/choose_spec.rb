# coding: us-ascii
require_relative 'helper'

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