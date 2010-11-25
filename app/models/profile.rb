#!/usr/bin/ruby
# The profile class is used to track information for a profile including their
# name and win/loss statistics.

require 'sqlite3'

class Profile
    # Constructor, takes the name of a user and instantiates the values
    # for a game. The profile also mantains a connection to the database.
    def initialize(name)
      @db = SQLite3::Database.new('db/data.sqlite3')
      @name = name.downcase
      new_game
    end
    attr_reader :name, :wins, :losses, :draws, :user_id
    
    # Creates a new game and restores the values
    def new_game
      @wins = 0
      @losses = 0
      @draws = 0
    end
    
    # Add a win
    def win!
      @wins += 1
    end
    
    # Add a loss
    def lose!
      @losses += 1
    end
    
    # Add a draw
    def draw!
      @draws += 1
    end
end
