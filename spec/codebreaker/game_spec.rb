require 'spec_helper'

module Codebreaker
  describe Game do
    describe "#start" do

      before do
        @game = Game.new
        @game.start(1,'anonymous')
      end

      it 'save secret code' do
        expect(@game.instance_variable_get(:@secret_code)).not_to be_empty
      end

      it 'saves 4 numbers secret code' do
        expect(@game.instance_variable_get(:@secret_code).size).to eq 4
      end
      
      it 'save secret code with numbers from 1 to 6' do
        expect(@game.instance_variable_get(:@secret_code)).to match(/[1-6]+/)
      end

      it 'check return value false' do
        gu = 'qwer'
        expect(@game.guess(gu)).to eq false
      end

      it 'check method wins' do
        @game.instance_variable_set(:@secret_code, '1234')
        gu = '1234'
        expect(@game.guess(gu)).to eq 1
      end

      it 'check method game over' do
        @game.instance_variable_set(:@secret_code, '1234')
        gu = '5642'
        expect(@game.guess(gu)).to eq 0
      end

      it 'check output sovpadenie' do
        @game.instance_variable_set(:@turns, 2)
        @game.instance_variable_set(:@secret_code, '1234')
        gu = '1555'
        expect(@game.guess(gu)).to eq '+'
      end

      it 'check output sovpadenie_2' do
        @game.instance_variable_set(:@turns, 4)
        @game.instance_variable_set(:@secret_code, '1234')
        gu = '1255'
        expect(@game.guess(gu)).to eq "++"
      end

      it 'check output sovpadenie_3' do
        @game.instance_variable_set(:@turns, 4)
        @game.instance_variable_set(:@secret_code, '1234')
        gu = '1235'
        expect(@game.guess(gu)).to eq "+++"
      end

      it 'check output sovpadenie_4' do
        @game.instance_variable_set(:@turns, 4)
        @game.instance_variable_set(:@secret_code, '1234')
        gu = '5155'
        expect(@game.guess(gu)).to eq "-"
      end

      it 'check output ne na svoem meste_1' do
        @game.instance_variable_set(:@turns, 4)
        @game.instance_variable_set(:@secret_code, '1234')
        gu = '5155'
        expect(@game.guess(gu)).to eq "-"
      end

      it 'check output ne na svoem meste_2' do
        @game.instance_variable_set(:@turns, 4)
        @game.instance_variable_set(:@secret_code, '1234')
        gu = '5125'
        expect(@game.guess(gu)).to eq "--"
      end

      it 'check output ne na svoem meste_3' do
        @game.instance_variable_set(:@turns, 4)
        @game.instance_variable_set(:@secret_code, '1234')
        gu = '5123'
        expect(@game.guess(gu)).to eq "---"
      end

      it 'check output ne na svoem meste_4' do
        @game.instance_variable_set(:@turns, 4)
        @game.instance_variable_set(:@secret_code, '1234')
        gu = '4321'
        expect(@game.guess(gu)).to eq "----"
      end

      it "return answ to guess" do
        @game.start(2)
        expect(@game.guess("1234")).to match(/^[+-]*$/)
      end

      context "#log" do
        it "logs file" do
          @game.start(5)
          @game.instance_variable_set(:@secret_code, "5634")
          @game.guess("1234")
          file = double('file')
          expect(File).to receive(:open).with("temp_file", "a").and_return(file)
          expect(file).to receive(:puts).with("Hi, anonymous")
          expect(file).to receive(:puts).with("Code 5634")
          expect(file).to receive(:puts).with("Max turns 5")
          expect(file).to receive(:puts).with("***:)(:***")
          expect(file).to receive(:close)
          @game.log('temp_file'){}
        end
      end

    end
  end
end