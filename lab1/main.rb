    def greeting
        print "Введите имя "
        name = gets.chomp
        print "Введите фамилию "
        first_name = gets.chomp
        print "Введите возраст "
        age = gets.to_i  
        text = "Привет, #{name.capitalize} #{first_name.capitalize}. "
        if age < 18
            text + "Тебе меньше 18 лет, но начать учиться программировать никогда не рано."
        else
            text + "Самое время заняться делом!"
        end
    end

    def foobar(a, b)
        if a == 20
            b
        elsif b == 20
            a
        else
            a + b
        end
    end

puts (foobar(20, 87))