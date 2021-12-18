class CashMachine

    def initialize()
        File.exist?("balance.txt") ? @balance = File.read("balance.txt").split("\n")[0].to_f : @balance = 100.0
    end
    
    #кладёт депозит на баланс
    def deposit(sum)
        if sum <= 0
            puts "Error: enter the correct value."
            puts "Balance: #{@balance}"
        end
        @balance += sum
        "New balance: #{@balance}"
    end

    #вывод средств
    def withdraw(sum)
            if (sum <= 0) 
                puts "Error: enter the correct value."
                puts "Balance: #{@balance}"
                return 0
            elsif (sum > @balance)
                puts "Error: the entered amount exceeds the balance"
                puts "Balance: #{@balance}"
                return 0
            end
            @balance -= sum
            "New balance: #{@balance}"
    end

    def balance
      "Balance: #{@balance}"
    end

    def quit
        File.write("balance.txt", @balance)
    end
    
end