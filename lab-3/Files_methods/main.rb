LIST_PATH = 'file.txt'
BUFFER = 'buffer.txt'

#выводит все строки
def index
    File.foreach(LIST_PATH) { |line| puts line }
end

#находит конкретную строку в файле и выводит ее
def find(id)

    File.foreach(LIST_PATH).with_index do |line, index|
        if index == id
            return line
        end
    end

    puts "Строка пустая или не найдена"

end

#находит все строки, где есть указанный паттерн
def where(pattern)

    File.foreach(LIST_PATH) do |line|
        if line.include?(pattern)
            puts @line_id = line
        end
    end

    if !@line_id
        puts "Ничего не найдено"
    end 
end

#обновляет конкретную строку файла
def update(id, name)
    file = File.open(BUFFER, 'w')
    File.foreach(LIST_PATH).with_index do |line, index|
      file.puts(id == index ? name : line)
    end
  
    file.close
    File.write(LIST_PATH, File.read(BUFFER))
  
    if File.exist?(BUFFER)
        File.delete(BUFFER) 
    end
end
  

#удаляет строку
def delete(id)
    file = File.open(BUFFER, 'w')
    File.foreach(LIST_PATH).with_index do |line, index|
        if index != id 
            file.puts(line)
        end
    end
  
    file.close
    File.write(LIST_PATH, File.read(BUFFER))
  
    if File.exist?(BUFFER)
        File.delete(BUFFER) 
    end
end

def menu
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
        puts "Строки файла #{LIST_PATH}:"
        index()
    when 2
        print "Введите номер строки: "
        id = gets.to_i
        puts(find(id))
    when 3
        print "Введите значение: "
        text = gets.to_s
        where(text)
    when 4
        print "Введите номер строки: "
        id = gets.to_i
        print "Введите значение: "
        text = gets.to_s
        update(id, text)
        index()
    when 5
        print "Введите номер строки: "
        id = gets.to_i
        delete(id)
        index()
    when -1
      break
    else
        puts "Error: введите верный символ"
    end
end
end