#!/usr/bin/ruby
require 'app/controllers/engine'

puts "Rock Paper Scissors.rb\nWhat is your name?"
name = gets
engine = Engine.new(name, {})
"Type 'help' to view commands"
while true
  input = gets.split[0].to_sym
  puts engine.handle_input input
end
