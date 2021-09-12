File.exist?("balance.txt") ? $balance = File.read("balance.txt").split("\n")[0].to_i : $balance = 100

def deposit
    puts "Введите сумму депозита."
    print "Сумма должна быть больше нуля: "
    deposit = gets.to_i
    if deposit <= 0
        puts "Введено некоректное значение."
        puts "Ваш баланс: #{$balance}"
        return 0
    end
    $balance += deposit
    puts "Ваш баланс: #{$balance}"
end

def withdraw
        puts "Введите сумму вывода."
        print "Сумма должна быть больше нуля: "
        withdraw = gets.to_i
        if (withdraw <= 0) 
            puts "Введено некоректное значение."
            puts "Ваш баланс: #{$balance}"
            return 0
        elsif (withdraw >= $balance)
            puts "Сумма превышает баланс"
            puts "Ваш баланс: #{$balance}"
            return 0
        end
        $balance -= withdraw
        puts "Ваш баланс: #{$balance}"
end

def balance
    puts "Ваш баланс: #{$balance}"
end



loop do
    puts "="*20
    puts "ATM"
    puts "D Внести деньги"
    puts "W Вывести деньги"
    puts "B Показать баланс"
    puts "Q Выход"
    print "Вы ввели: "
    input = gets.to_s.chomp.capitalize()
    puts "="*20
    case input
    when "D"
        deposit
    when "W"
        withdraw
    when "B"
        balance
    when "Q"
        break
        File.write("balance.txt", $balance)
    else
        puts "Вы ввели неверный символ"
    end
end