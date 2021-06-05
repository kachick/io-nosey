# coding: utf-8
# frozen_string_literal: true

RSpec.describe IO::Nosey::VERSION do
  it do
    expect(IO::Nosey::VERSION.frozen?).to eq(true)
    expect(Gem::Version.correct?(IO::Nosey::VERSION)).to eq(true)
  end
end
