require 'rspec'
require './main.rb'

RSpec.describe "Main" do
    it "#inp_word" do
      allow_any_instance_of(Kernel).to receive(:gets).and_return("Random")
      expect(inp_word).to eq("modnaR")

      allow_any_instance_of(Kernel).to receive(:gets).and_return("specs")
      expect(inp_word).to eq("32")
    end
  end

  RSpec.describe "Main" do
    it "#add_pokemons" do
      allow_any_instance_of(Kernel).to receive(:gets).and_return(2, "Pikachu", "Yellow", "Ivi", "Brown")
      expect(add_pokemons).to eq([{:name=>"Pikachu", :color=>"Yellow"}, {:name=>"Ivi", :color=>"Brown"}])
    end
  end