require 'httparty'
require 'json'


# url = 'https://api.distancematrix.ai/maps/api/distancematrix/json'

# response = HTTParty.get( url + '?origins=Westminster Abbey Westminster London SW1P 3PA UK&destinations= Moscow Smolensky Blvd 17&key=15DYKJCNayz8uSH4gAh0TIsiBdkYp')

# puts JSON.parse(response.body)['rows'][0]['elements'][0]['distance']['value']

class Transfer

    attr_accessor :result
    def initialize
       @result = []
    end     

    def addTransfer
        puts "Введите параметры перевозимого груза:"
        print "Вес(кг): "
        @weight = gets.to_f
        print "Длина(см): "
        @length = gets.to_f
        print "Ширина(см): "
        @width = gets.to_f
        print "Высота(см): "
        @height = gets.to_f

        puts "Название пункта отправления"
        print "Страна: "
        @departure = gets.to_s
        print "Населённый пункт: "
        @departure += gets.to_s
        print "Улица: "
        @departure += gets.to_s
        print "Дом: "
        @departure += gets.to_s

        puts "Название пункта назначения"
        print "Страна: "
        @destination = gets.to_s
        print "Населённый пункт: "
        @destination += gets.to_s
        print "Улица: "
        @destination += gets.to_s
        print "Дом: "
        @destination += gets.to_s

        # Get the distance
        @url = 'https://api.distancematrix.ai/maps/api/distancematrix/json'
        @token = '15DYKJCNayz8uSH4gAh0TIsiBdkYp'
        @response = HTTParty.get("#{@url}?origins=#{@departure}&destinations=#{@destination}&key=#{@token}")
        @distance = JSON.parse(@response.body)['rows'][0]['elements'][0]['distance']['value'].to_i

        #Cargo size calculation
        @size = (@length / 100.0) * (@width / 100.0) * (@height / 100.0)

        if @size < 1.0
            @price = @distance / 1000.0
        elsif @weight <= 10
            @price = (@distance * 2) / 1000.0
        else
            @price = (@distance * 3) / 1000.0
        end
        
        @result.push({weight: @weight, width: @width, height: @height, distance: @distance, price: @price})
    end

end

test = Transfer.new()
puts test.addTransfer