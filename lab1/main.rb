
    def greeting
        print "Введите имя "
        name = gets.chomp
        print "Введите фамилию "
        first_name = gets.chomp
        print "Введите возраст "
        age = gets.to_i  
        text = "Привет, #{name.capitalize()} #{first_name.capitalize()}. "
        if age < 18
            return text + "Тебе меньше 18 лет, но начать учиться программировать никогда не рано."
        else
            return text + "Самое время заняться делом!"
        end
    end

    def foobar
        print "Введите первое число "
        a = gets.to_i
        print "Введите второе число "
        b = gets.to_i
        if a == 20
            return b
        elsif b == 20
            return a
        else
            return a + b
        end
    end
greeting