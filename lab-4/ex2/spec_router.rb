require 'rspec'
require 'stringio'

require './router.rb'

RSpec.describe Router do

    it 'create new post' do
        allow_any_instance_of(Router).to receive(:gets).and_return("1", "q")
        allow_any_instance_of(Resource).to receive(:gets).and_return("POST", "q")
        allow_any_instance_of(PostsController).to receive(:gets).and_return("Пост")
        router = Router.new()
        expect(router.init)
        expect do
          PostsController.new.create
        end.to output("Введите содержимое поста:\n0: Пост\n").to_stdout
    end

    it 'create new post error' do
      allow_any_instance_of(Router).to receive(:gets).and_return("1", "q")
      allow_any_instance_of(Resource).to receive(:gets).and_return("POST", "q")
      allow_any_instance_of(PostsController).to receive(:gets).and_return("")
      router = Router.new()
      expect(router.init)
      expect do
        PostsController.new.create
      end.to output("Введите содержимое поста:\nError: введённое значение пустое\n").to_stdout
  end

    it 'create new post and show' do
        allow_any_instance_of(Router).to receive(:gets).and_return("1", "q")
        allow_any_instance_of(Resource).to receive(:gets).and_return("POST", "GET", "show", "q")
        allow_any_instance_of(PostsController).to receive(:gets).and_return("Пост", "0")
        router = Router.new()
        expect(router.init)
        expect do
          PostsController.new.show
        end.to output("Введите id:\n0: Пост\n").to_stdout
    end

    it 'create new post and show error' do
        allow_any_instance_of(Router).to receive(:gets).and_return("1", "q")
        allow_any_instance_of(Resource).to receive(:gets).and_return("POST", "GET", "show", "q")
        allow_any_instance_of(PostsController).to receive(:gets).and_return("Пост", "1")
        router = Router.new()
        expect(router.init)
        expect do
          PostsController.new.show
        end.to output("Введите id:\nError: введите корректный id\n").to_stdout
    end
    

    it 'create new posts and viewing them' do
      allow_any_instance_of(Router).to receive(:gets).and_return("1", "q")
      allow_any_instance_of(Resource).to receive(:gets).and_return("POST","POST", "GET", "index", "q")
      allow_any_instance_of(PostsController).to receive(:gets).and_return("Пост0", "Пост1")
      router = Router.new()
      expect(router.init)
      expect do
        PostsController.new.create
      end.to output("Введите содержимое поста:\n0: Пост0\n").to_stdout
    end

    it 'change the post' do
      allow_any_instance_of(Router).to receive(:gets).and_return("1", "q")
      allow_any_instance_of(Resource).to receive(:gets).and_return("POST","POST", "PUT", "q")
      allow_any_instance_of(PostsController).to receive(:gets).and_return("Пост0", "Пост1", "1", "НовыйПост1")
      router = Router.new()
      expect(router.init)
      expect do
        PostsController.new.create
      end.to output("Введите содержимое поста:\n0: Пост0\n").to_stdout
    end

    it 'change the post error' do
      allow_any_instance_of(Router).to receive(:gets).and_return("1", "q")
      allow_any_instance_of(Resource).to receive(:gets).and_return("POST","POST", "PUT", "q")
      allow_any_instance_of(PostsController).to receive(:gets).and_return("Пост0", "Пост1", "5", "НовыйПост1")
      router = Router.new()
      expect(router.init)
      expect do
        PostsController.new.update
      end.to output("Введите id:\nError: введите корректный id\n").to_stdout
    end

    it 'delete the post' do
      allow_any_instance_of(Router).to receive(:gets).and_return("1", "q")
      allow_any_instance_of(Resource).to receive(:gets).and_return("POST","POST", "DELETE", "q")
      allow_any_instance_of(PostsController).to receive(:gets).and_return("Пост0", "Пост1", "1")
      router = Router.new()
      expect(router.init)
      expect do
        PostsController.new.create
      end.to output("Введите содержимое поста:\n0: Пост0\n").to_stdout
    end

    it 'delete the post error' do
      allow_any_instance_of(Router).to receive(:gets).and_return("1", "q")
      allow_any_instance_of(Resource).to receive(:gets).and_return("POST","POST", "DELETE", "q")
      allow_any_instance_of(PostsController).to receive(:gets).and_return("Пост0", "Пост1", "6")
      router = Router.new()
      expect(router.init)
      expect do
        PostsController.new.destroy
      end.to output("Введите id:\nError: введите корректный id\n").to_stdout
    end

    it 'create new comment' do
      allow_any_instance_of(Router).to receive(:gets).and_return("2", "q")
      allow_any_instance_of(Resource).to receive(:gets).and_return("POST", "q")
      allow_any_instance_of(CommentsController).to receive(:gets).and_return("Комментарий")
      router = Router.new()
      expect(router.init)
      expect do
        CommentsController.new.create
      end.to output("Введите комментарий:\n0: Комментарий\n").to_stdout
  end


end