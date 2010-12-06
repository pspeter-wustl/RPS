#!/usr/bin/ruby
# == Synopsis 
#   This app plays Rock, Paper, Scissors with users and hopes to win against
#   the average player not using a random strategy.

# Main program
puts "Rock Paper Scissors.rb\nWhat is your name?"
print ">> "
name = gets
engine = Engine.new(name, 
  {
  :max_search => 5,
  :max_history => 50,
  :analyze_user => true,
  :analyze_computer => false,
  })
engine.run!
