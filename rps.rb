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
#   -c, --computer      Disables analyzing the computer
#   -u, --user          Disables analyzing the user 
#   -s, --search        Search pattern length, default is 5
#   -p, --past          How far to look back into the past, default is 50
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
