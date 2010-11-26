#!/usr/bin/ruby
require 'app/models/profile'
require 'app/controllers/thinker'
# The Engine class handles the input and ties the Profile and Thinker classes
# together
class Engine
  # The constructor takes in the arguments passed to it by the main program
  # and passes it to the Thinker
  def initialize(name, args)
    @args = args
    @thinker = Thinker.new(args)
    @profile = Profile.new(name, @thinker.args)
  end
  
  # Handles the input for the class and returns 
  def handle_input(input)
    return "Invalid input" unless self.respond_to? input
    self.send input
  end
  
  # Handles rock
  def rock
    handle_move(0)
  end
  
  # Handles paper
  def paper
    handle_move(1)
  end
  
  # Handles scissors
  def scissors
    handle_move(2)
  end
  
  # Handles the reset
  def reset
    @profile.new_game
    @thinker = Thinker.new(@args)
  end
  
  # Handles game results
  def game
    "Game Results: " + results_to_s(@profile.game_record)
  end
  
  # Handles the user results
  def user
    "User Results: " + results_to_s(@profile.user_record)
  end
  
  # Handles the global results
  def global
    "Global Results: " + results_to_s(@profile.global_record)
  end
  
  # Returns the help string
  def help
    help = <<HEREDOC 
reset - creates a new game
rock - throws rock
paper - throws paper
scissors - throws scissors
help - shows this screen
game - shows the results from this game
user - shows your results from all your games
global - shows the global results from all users
exit - quit the game
HEREDOC
  end
  
  # Returns the goodbye notice
  def exit
    "Goodbye! Thanks for playing!"
  end
  
  private
  # Handles a move by recording it in the thinker and the profile as well as
  # returning the appropriate output.
  def handle_move(user)
    # moves
    moves = {0 => "Rock", 1 => "Paper", 2 => "Scissors"}
    comp = @thinker.think
    @thinker.add(user, comp)
    temp = "You played #{moves[user]} and the computer played #{moves[comp]}. "
    case
      when (user + 1) % 3 == comp
        temp += "You lost..."
        @profile.lose!
      when user == (comp + 1 ) % 3
        temp += "You won!"
        @profile.win!
      when user == comp
        temp += "You drew."
        @profile.draw!
    end
    temp
  end
  
  # Returns the results of a hash
  def results_to_s(results)
    temp = [:wins, :draws, :losses].map do |k|
      k = k.to_s.capitalize + ": " + results[k].to_s
    end
    temp = temp.join(", ")
    if results[:wins] + results[:losses] > 0 
      ratio = (results[:wins].to_f / (results[:wins] + results[:losses])) * 100
      temp += " Ratio: #{ratio.to_i}%"
    end
    temp
  end 
end
