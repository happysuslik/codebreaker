
module Codebreaker
  class Game
    attr_reader :turns
    def start(turns, name = 'anonymous')
      @name = name
      @turns = 1
      @turns = turns if turns > 0
      @turns_was = @turns
      @log = []
      generate_code
    end

    def generate_code
      @secret_code = ''
      4.times{ @secret_code << (1 + rand(6)).to_s}
    end


    # Выполнение логики, поиска одинаковых элементов
    def guess(gu)
      return false unless valid?(gu)
      @turns -= 1
      answ = []
      guess = gu.clone
      secret = @secret_code.clone

      guess.size.times do |index|
        if guess[index] == secret[index]
          answ << '+'
          secret[index] = '0'
          guess[index] = 'a'
        end
      end

      secret.each_char do |value|
        if guess.include? value
          answ << '-'
          guess.sub!(value, 'a')
        end
      end

      rez = 1 if answ == ['+', '+', '+', '+']
      rez ||= 0 if @turns == 0 # Присваиваем rez 0, если попытки равны 0
      rez ||= answ.join # Если результат nill, присваиваем  строку
      @log << {result: rez, guess: gu}
      rez
    end

    def hint
      puts @secret_code[rand(@secret_code.size)]
    end

    # Добавляю в конец файла информацию из лога
    def log(name_file)
      file = File.open(name_file, 'a')
      file.puts("Hi, #{@name}")
      file.puts("Code #{@secret_code}")
      file.puts("Max turns #{@turns_was}")
      @log.each{|x| yield(file, x)}
      file.puts("***:)(:***")
    ensure
      file.close if file
    end

    private

    def valid?(gu)
      gu =~ /^[1-6]{4}$/
    end
  end
end