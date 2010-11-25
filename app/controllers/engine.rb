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
  end
end
