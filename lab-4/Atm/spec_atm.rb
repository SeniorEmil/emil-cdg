require 'rspec'
require 'stringio'

require './CashMachine.rb'

describe CashMachine do
    before { @atm = CashMachine.new()}

    #ввод депозита
    it 'deposit entry' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("D", "200", "Q")
        expect(@atm.init)
        expect(File.read("balance.txt")).to eql("300.0")
    end

    #вывод средств
    it 'withdrawal of funds' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("W", "200", "Q")
        expect(@atm.init)
        expect(File.read("balance.txt")).to eql("100.0")
    end

    #показать баланс
    it 'balance' do
      allow_any_instance_of(Kernel).to receive(:gets).and_return("B", "Q")
      expect(@atm.init)
      expect(File.read("balance.txt")).to eql("100.0")
    end

end