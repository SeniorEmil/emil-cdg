require 'fileutils'

def where(inp_file, outp_file, name)
    file = File.open(outp_file, 'a')
    File.foreach(inp_file) do |line|
        if line.split.last == name
            file.puts(line)
        end
    end
    file.close
end


def search_students_year
    years = []
    stud_size = File.open("students.txt").read.count(" ")
    loop do     
        puts "Для выхода введите (-1)"
        print "Введите возраст студента(тов): "
        input = gets.to_i

        if input == -1
            break
        elsif (input < -1) || (input == 0)
            puts "Введите корректное значение"
        elsif years.include?(input)
            puts "Вы вводили данный возраст ранее"
        else
            #Добавить года, чтобы не повторяться
            years.push(input)

            #Удалить файл results если существует при запуске
            if (years.size == 1)
                File.exists?("results.txt") ? File.delete("results.txt") : 0
            end

            #Запись в файл results.txt строки соответствующие ключу из students.txt
            where("students.txt", "results.txt", input.to_s)

            #количество слов в файле results 
            puts result_size = File.open("results.txt").read.count(" ")

            #Сравнение количества слов в файлах
            if (result_size == stud_size)
               puts "Записаны все студенты."
              break
            end
        end
    end
    puts "Вывод файла results.txt"
    File.foreach("results.txt") { |line| puts(line.chomp) }
end

search_students_year