#выводит все строки
def index(file_name)
    puts "Строки файла #{file_name}:"
    File.foreach(file_name) { |line| puts(line.chomp) }
end

#находит конкретную строку в файле и выводит ее
def find(id)
    flag = true
    File.foreach("file.txt").with_index do |line, index|
        if index == id
            puts line
            return line
        end
    end

    if flag
        puts "Строка пустая или не найдена"
    end
end

#находит все строки, где есть указанный паттерн
def where(file_name, pattern)
    File.foreach(file_name) do |line|
        if line.include?(pattern)
            puts(line)
        end
    end
end

#обновляет конкретную строку файла
def update(id, text)
    buffer = []

    File.foreach("file.txt").with_index do |line, index|
        index == id ? buffer.push(text) : buffer.push(line)
    end
    
    File.open("file.txt", "w") do |file|
        buffer.each {|line| file.puts(line)}
    end
end

#удаляет строку
def delete(id)
    buffer = []

    File.foreach("file.txt").with_index do |line, index|
        if index != id 
            buffer.push(line)
        end
    end
    
    File.open("file.txt", "w") do |file|
        buffer.each {|line| file.puts(line)}
    end
end

loop do
    puts "="*20
    puts "1 Вывести все строки"
    puts "2 Вывести строку по номеру"
    puts "3 Вывести все строки с введённым значением"
    puts "4 Изменить строку"
    puts "5 Удалить строку"
    puts "(-1) Выход из программы"
    print "Вы ввели: "
    input = gets.to_i
    puts "="*20
    case input
    when 1
        index("file.txt")
    when 2
        print "Введите номер строки: "
        id = gets.to_i.chomp
        find(id)
    when 3
        print "Введите значение: "
        text = gets.to_s
        where("file.txt", text)
    when 4
        print "Введите номер строки: "
        id = gets.to_i
        print "Введите значение: "
        text = gets.to_s
        update(id, text)
        index("file.txt")
    when 5
        print "Введите номер строки: "
        id = gets.to_i
        delete(id)
        index("file.txt")
    when -1
      break
    else
        puts "Error: введите верный символ"
    end
end