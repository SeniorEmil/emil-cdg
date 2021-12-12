module Resource
    def connection(routes)
      if routes.nil?
        puts "No route matches for #{self}"
        return
      end
  
      loop do
        print 'Choose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: '
        verb = gets.chomp
        break if verb == 'q'
  
        action = nil
  
        if verb == 'GET'
          print 'Choose action (index/show) / q to exit: '
          action = gets.chomp
          break if action == 'q'
        end
  
        action.nil? ? routes[verb].call : routes[verb][action].call
      end
    end
  end
  
  class PostsController
    extend Resource
  
    def initialize
      @posts = []
    end
  
    def index
        @posts.each_with_index do |post, index|
            puts "#{index}: #{post}"
        end
    end
  
    def show
        puts "Введите id:"
        id = gets.to_i
        if id < 0 || id >= @posts.length
            puts "Error: введите корректный id"
        else
            puts "#{id}: #{@posts[id]}"
        end
    end
  
    def create
        puts 'Введите содержимое поста:'
        post = gets.chomp
        if post == ""
            puts "Error: введённое значение пустое"
        else
            @posts.append(post)
            puts "#{@posts.length - 1}: #{post}"        
        end
    end
  
    def update
        puts "Введите id:"
        id = gets.to_i
        if id < 0 || id >= @posts.length
            puts "Error: введите корректный id"
        else
            puts "Введите новое содержимое"
            post = gets.chomp
            @posts[id] = post
            puts "#{id}: #{post}"    
        end
    end
  
    def destroy
        puts "Введите id:"
        id = gets.to_i
        if id < 0 || id >= @posts.length
            puts "Error: введите корректный id"
        else
            @posts.delete_at(id)
            puts "пост с id = #{id} удалён"    
        end
    end
  end

  class CommentsController
    extend Resource
  
    def initialize
      @comments = []
    end
  
    def index
        @comments.each_with_index do |comment, index|
            puts "#{index}: #{comment}"
        end
    end
  
    def show
        puts "Введите id:"
        id = gets.to_i
        if id < 0 || id >= @comments.length
            puts "Error: введите корректный id"
        else
            puts "#{id}: #{@comments[id]}"
        end
    end
  
    def create
        puts 'Введите комментарий:'
        comment = gets.chomp
        if comment == ""
            puts "Error: введённое значение пустое"
        else
            @comments.append(comment)
            puts "#{@comments.length - 1}: #{comment}"        
        end
    end
  
    def update
        puts "Введите id:"
        id = gets.to_i
        if id < 0 || id >= @comments.length
            puts "Error: введите корректный id"
        else
            puts "Введите новый комментарий"
            comment = gets.chomp
            @comments[id] = comment
            puts "#{id}: #{comment}"    
        end
    end
  
    def destroy
        puts "Введите id:"
        id = gets.to_i
        if id < 0 || id >= @comments.length
            puts "Error: введите корректный id"
        else
            @comments.delete_at(id)
            puts "Комментарий с id = #{id} удалён"    
        end
    end
  end
  
  class Router
    def initialize
      @routes = {}
    end
  
    def init
      resources(PostsController, 'posts')
      resources(CommentsController, 'comments')
  
      loop do
        print 'Choose resource you want to interact (1 - Posts, 2 - Comments, q - Exit): '
        choise = gets.chomp
  
        PostsController.connection(@routes['posts']) if choise == '1'
        CommentsController.connection(@routes['comments']) if choise == '2'
        break if choise == 'q'
      end
  
      puts 'Good bye!'
    end
  
    def resources(klass, keyword)
      controller = klass.new
      @routes[keyword] = {
        'GET' => {
          'index' => controller.method(:index),
          'show' => controller.method(:show)
        },
        'POST' => controller.method(:create),
        'PUT' => controller.method(:update),
        'DELETE' => controller.method(:destroy)
      }
    end
  end
  
  # router = Router.new
  # router.init