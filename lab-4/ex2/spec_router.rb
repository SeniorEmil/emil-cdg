require 'rspec'
require 'stringio'

require './router.rb'

describe Router do

    # it 'create new post' do
    #     allow_any_instance_of(Router).to receive(:gets).and_return("1", "q")
    #     allow_any_instance_of(Resource).to receive(:gets).and_return("POST", "q")
    #     allow_any_instance_of(PostsController).to receive(:gets).and_return("Нулевой пост")
    #     atm = Router.new()
    #     expect(atm.init)
    #     expect do
    #       PostsController.new.create
    #     end.to output("Введите содержимое поста:\n0: Нулевой пост\n").to_stdout
    # end

    #
    it 'create new post and show' do
        allow_any_instance_of(Router).to receive(:gets).and_return("1", "q")
        allow_any_instance_of(Resource).to receive(:gets).and_return("POST", "GET", "show", "q")
        allow_any_instance_of(PostsController).to receive(:gets).and_return("Пост", "3")
        atm = Router.new()
        expect(atm.init)
        expect do
          PostsController.new.create
        end.to output("").to_stdout
    end

    # #вывод средств
    # it 'withdrawal of funds' do
    #     allow_any_instance_of(Kernel).to receive(:gets).and_return("W", "200", "Q")
    #     expect(@atm.init)
    #     expect(File.read("balance.txt")).to eql("100.0")
    # end

    # #показать баланс
    # it 'balance' do
    #   allow_any_instance_of(Kernel).to receive(:gets).and_return("B", "Q")
    #   expect(@atm.init)
    #   expect(File.read("balance.txt")).to eql("100.0")
    # end

end