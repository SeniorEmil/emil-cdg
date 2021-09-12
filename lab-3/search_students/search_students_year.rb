def search_students_year
    students =[]
    results = []
    years = []
    File.foreach("students.txt") { |line| students.push(line.chomp)}

    loop do     
        puts "Для выхода введите (-1)"
        print "Введите возраст студента(тов): "
        input = gets.to_i

        if input == -1
            break
        elsif years.include?(input)
            puts "Вы вводили данный возраст ранее"
        else
            years.push(input)
            results += students.grep(/#{input}/) 
            File.open("results.txt", "w") do |file|
                results.each { |x| file.puts(x) }
            end
            if (students.size == results.size)
                puts "Записаны все студенты."
                break
            end
        end
    end
    File.foreach("results.txt") { |line| p(line.chomp) }
end

search_students_year