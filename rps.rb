#!/usr/bin/ruby
# == Synopsis 
#   This app plays Rock, Paper, Scissors with users and hopes to win against
#   the average player not using a random strategy.
#
# == Usage 
#   rps [options]
#
#   For help use: rps -h
#
# == Options
#   -h, --help          Displays help message
#
# == Author
#   Phips Peter

require 'app/controllers/engine'
require 'optparse'

# Main program
puts "Rock Paper Scissors.rb\nWhat is your name?"
print ">> "
name = gets
engine = Engine.new(name, {:analyze_computer => false})
engine.run!
