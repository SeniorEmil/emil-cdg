require 'rspec'
require './main.rb'

RSpec.describe "Main" do
    it "#inp_word" do
      expect(inp_word("Random")).to eq("modnaR")

      expect(inp_word("specs")).to eq("32")
    end
  end

  RSpec.describe "Main" do
    it "#add_pokemons" do
      allow_any_instance_of(Kernel).to receive(:gets).and_return(2, "Pikachu", "Yellow", "Ivi", "Brown")
      expect(add_pokemons).to eq([{:name=>"Pikachu", :color=>"Yellow"}, {:name=>"Ivi", :color=>"Brown"}])
    end
  end