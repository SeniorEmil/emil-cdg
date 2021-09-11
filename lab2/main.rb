def word(num, word)
    size_word = word.length
    (word.to_s.slice(size_word-2, size_word-1) == "cs") ? puts("#{2**size_word}") : puts("#{word.reverse}")

end

def arr_pokemons
    print "Введите количество покемонов "
    i = gets.to_i
    pokemons = []
    i.times do |value|
        print "Введите имя покемона № #{value+=1} "
        name = gets.chomp
        print "Введите цвет покемона № #{value} "
        color = gets.chomp
        pokemons.push({name: name, color: color})
    end
    puts pokemons
end

#word 2, "kics"
arr_pokemons