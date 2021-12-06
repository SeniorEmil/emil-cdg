require 'rspec'
require 'stringio'

require './search_students_year.rb'

RSpec.describe "Search_students_year" do
    it 'should sort people by age - 20, 19, 1 and show them' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("20", "19", "1", "-1")
        expect(menu)
        expect(File.read("results.txt")).to eql("Анастасия Носкова 20\nЯрослав Матвеев 20\nЗлата Соколова 20\nЕлизавета Маслова 19\nАглая Федорова 19\nВасилиса Сидорова 19\n")
    end

    it 'recording of all students' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("20", "19", "18", "21", "-1")
        expect(menu)
        expect($OUTPUT).to eql("Записаны все студенты.")
    end
end