require 'rspec'
require './main.rb'

RSpec.describe "Main" do
    it "#foobar" do
      allow_any_instance_of(Kernel).to receive(:gets).and_return("20", "1")
      expect(foobar).to eq(1)

      allow_any_instance_of(Kernel).to receive(:gets).and_return("5", "20")
      expect(foobar).to eq(5)

      allow_any_instance_of(Kernel).to receive(:gets).and_return("10", "19")
      expect(foobar).to eq(29)
    end
  end

  RSpec.describe "Main" do
    it "#greeting" do
      allow_any_instance_of(Kernel).to receive(:gets).and_return("эмиль", "ибраимов", 19)
      expect(greeting).to eq("Привет, Эмиль Ибраимов. Самое время заняться делом!")

      allow_any_instance_of(Kernel).to receive(:gets).and_return("эмиль", "ибраимов", 15)
      expect(greeting).to eq("Привет, Эмиль Ибраимов. Тебе меньше 18 лет, но начать учиться программировать никогда не рано.")
    end
  end