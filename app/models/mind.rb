#!/usr/bin/ruby

# The Mind class stores a vector in the three dimensional rock, paper, scissors
# space. The mind class can also return what value the computer should play
class Mind
  # Constructor, holds values for the rock, paper and scissor weights as an
  # internal array in [r,p,s] order
  def initialize
    @rps = [0,0,0]
  end
  
  # Gets the weight for rock
  def rock
    @rps[0]
  end
  
  # Gets the weight for paper
  def paper
    @rps[1]
  end
  
  # Gets the weight for scissors
  def scissors
    @rps[2]
  end
  
  # Updates the mind use weighted exponential smoothing. The weight is based
  # on the (number of times the pattern was seen)/(length of history / length
  # of the pattern). This can be simplified to (pattern.count * pattern.size) /
  # history.size
  def add(count, pattern_length, history_length, move)
    # Set the initial thought and then update the move
    thought = [0,0,0]
    puts move
    thought[move] = 1
    # Calculate the weight
    weight = (count * pattern_length) / history_length.to_f
    # Loop through and update the values
    (0..2).each {|i| @rps[i] = (@rps[i] * (1-weight)) + (thought[i] * weight)}
  end
  
  # Returns the max weights
  def max_weights
    # find the max weigth
    temp = 0
    index = -1
    (0..2).each do |i|
      if @rps[i] > temp
        temp = @rps[i]
        index = i
      end
    end
    weights = []
    # Adds all the max weights
    (0..2).each {|i| weights << i if @rps[i] == @rps[index]}
    weights
  end
end
