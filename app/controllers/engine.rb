#!/usr/bin/ruby

# The Engine class handles the input and ties the Profile and Thinker classes
# together
class Engine
  # The constructor takes in the arguments passed to it by the main program
  # and passes it to the Thinker
  def initialize(name, args)
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
end
