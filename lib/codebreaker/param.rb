
module Codebreaker

  game = Game.new

  puts 'New game'
  puts 'Input you name:'
  name = gets.chomp

  def self.tries
    puts 'Input number turns (0 exit):'
    gets.chomp.to_i
  end

  def self.guess
     puts 'Input 4 values from 1 to 6'
     gets.chomp
   end

   def self.chest(text_game)
     case text_game
       when 1
         'Bingo, you wins'
       when 0
         'Fail! Go, next!'
       when false
         'not the correct value'
       else
        text_game
    end
   end

  tr = tries


  def self.chest_tries(test_tries)
    case test_tries
      when 0
        'Not the correct value'
      else
        'You have ' + "#{test_tries} " + 'attempts'
    end
  end

  puts chest_tries(tr)

  def self.log(game)
    game.log('log') do |file, text|
      file.puts("You input:", text[:guess])
      file.puts(chest(text[:result]))
    end
  end

  # цикл старта игры основываясь на попытках
  until tr == 0 do
    game.start(tr, name)
    begin
      text_game = game.guess(guess)
      p chest(text_game)
    end until (text_game == 0) || (text_game == 1)
    puts 'log?(y/n)'
    out_log = gets.chomp
    log(game) if out_log == 'y'
    tr = tries
  end
end
