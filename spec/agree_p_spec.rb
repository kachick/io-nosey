# coding: us-ascii
# frozen_string_literal: true

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

  describe '#agree?' do

    before :each do
      @prompt = 'Are you crazy? :)'
    end

    context 'with affirmative inputs' do
      context 'when the input is "y"' do
        it 'returns true' do
          np_input 'y'
          ret = @np.agree? @prompt
          expect(ret).to be(true)
        end
      end

      context 'when the input is "Y"' do
        it 'returns true' do
          np_input 'Y'
          ret = @np.agree? @prompt
          expect(ret).to be(true)
        end
      end
    end

    context 'with negative inputs' do
      context 'when the input is "n"' do
        it 'returns false' do
          np_input 'n'
          ret = @np.agree? @prompt
          expect(ret).to be(false)
        end
      end

      context 'when the input is "N"' do
        it 'returns false' do
          np_input 'N'
          ret = @np.agree? @prompt
          expect(ret).to be(false)
        end
      end
    end

  end

end
