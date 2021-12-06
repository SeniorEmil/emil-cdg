require 'fileutils'

$OUTPUT

#Запись в файл outp_file строки соответствующие ключу из inp_file
def where(inp_file, outp_file, name)
    file = File.open(outp_file, $years.length == 1 ? 'w' : 'a')
    File.foreach(inp_file) do |line|
        if line.split.last == name
            file.puts(line)
        end
    end
    file.close
end


def menu
    $years = []
    stud_size = File.open("students.txt").read.count(" ")
    # File.exists?("results.txt") ? File.delete("results.txt") : 0
    loop do     
        puts "Для выхода введите (-1)"
        print "Введите возраст студента(тов): "
        input = gets.to_i

        if input == -1
            break
        elsif (input < -1) || (input == 0)
            puts "Введите корректное значение"
        elsif $years.include?(input)
            puts "Вы вводили данный возраст ранее"
        else
            #Добавить года, чтобы не повторялись
            $years.push(input)

            #Запись в файл results.txt строки соответствующие ключу из students.txt
            where("students.txt", "results.txt", input.to_s)

            #количество слов в файле results 
            puts result_size = File.open("results.txt").read.count(" ")

            #Сравнение количества слов в файлах
            if (result_size == stud_size)
               puts $OUTPUT = "Записаны все студенты."
               break
            end
        end
    end
    puts "Вывод файла results.txt"
    File.foreach("results.txt") { |line| puts(line.chomp) }
end

