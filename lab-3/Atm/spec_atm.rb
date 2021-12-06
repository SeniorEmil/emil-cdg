require 'rspec'
require 'stringio'

require './atm.rb'


RSpec.describe "ATM" do
    
    #ввод отрицательного депозита
    it 'enter a negative deposit' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("D", "-16", "Q")
        expect(menu)
        expect($ERROR).to eql("Error: введите корректное значение.")
    end

    #ввод отрицательной суммы вывода
    it 'enter a negative withdrawal amount' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("W", "-16", "Q")
        expect(menu)
        expect($ERROR).to eql("Error: введите корректное значение.")
    end

    #ввод суммы вывода больше баланса
    it 'entering the withdrawal amount is more than the balance' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("W", "3000", "Q")
        expect(menu)
        expect($ERROR).to eql("Error: введённая сумма превышает баланс")
    end

    #ввод депозита
    it 'deposit entry' do
        $balance = 100.0
        allow_any_instance_of(Kernel).to receive(:gets).and_return("d", "200", "Q")
        expect(menu)
        expect(File.read("balance.txt")).to eql("300.0")
    end

    #вывод средств
    it 'withdrawal of funds' do
        $balance = 100.0
        allow_any_instance_of(Kernel).to receive(:gets).and_return("w", "20.5", "Q")
        expect(menu)
        expect(File.read("balance.txt")).to eql("79.5")
    end

end


