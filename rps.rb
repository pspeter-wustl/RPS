#!/usr/bin/ruby
require 'app/controllers/engine'

name = gets
engine = Engine.new(name, {})
while true
  input = gets.split[0].to_sym
  puts engine.handle_input input
end
