require './lib/game.rb'

class Conway
  glider = [[0, 1], [1, 2], [2, 0], [2, 1], [2, 2]]
  exploder = [
    [9, 9], [9, 11], [9, 13],
    [10, 9], [10, 13],
    [11, 9], [11, 13],
    [12, 9], [12, 13],
    [13, 9], [13, 11], [13, 13]
  ]

  game = Game.new

  puts 'Select the figure you want to play'
  puts 'press "q<Enter>" to exit'
  puts '1.- Glider 2.- Exploder'

  Thread.new do
    loop do
      exit if gets.chomp.casecmp('q').zero?
    end
  end

  loop do
    print '> '
    figure = gets.chomp.to_i
    case figure
    when 1
      game.draw_figure(glider)
      break
    when 2
      game.draw_figure(exploder)
      break
    else
      puts 'Incorrect choice'
    end
  end

  loop do
    system('clear')
    game.draw_board
    game.next_generation
    sleep 1
  end
end
