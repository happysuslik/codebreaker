require 'spec_helper'

module Codebreaker
  describe '#Param' do

    it 'check output chest value 1' do
      text_game = 1
      expect(Codebreaker.chest(text_game)).to eq 'Bingo, you wins'
    end

    it 'check output chest value 0' do
      text_game = 0
      expect(Codebreaker.chest(text_game)).to eq 'Fail! Go, next!'
    end

    it 'check output chest value false' do
      text_game = false
      expect(Codebreaker.chest(text_game)).to eq 'not the correct value'
    end

    it 'check output chest return value' do
      text_game = '+'
      expect(Codebreaker.chest(text_game)).to eq '+'
    end

    it 'check output chest_tries value' do
      tries = 1
      expect(Codebreaker.chest_tries(tries)).to eq 'You have 1 attempts'
    end

    it 'check output chest_tries value false' do
      tries = 0
      expect(Codebreaker.chest_tries(tries)).to eq 'Not the correct value'
    end

  end
end