#!/usr/bin/ruby
# The profile class is used to track information for a profile including their
# name and win/loss statistics.

require 'sqlite3'

class Profile
    # Constructor, takes the name of a user and instantiates the values
    # for a game. The profile also mantains a connection to the database.
    def initialize(name)
      @db = SQLite3::Database.new('db/data.sqlite3')
      @db.type_translation = true
      @db.results_as_hash = true
      @name = name.downcase.strip
      user = @db.get_first_row("SELECT id FROM users WHERE name=?", [@name])
      if user == nil
        @db.execute("INSERT INTO users VALUES(null,?)", [@name])
        @user_id = @db.last_insert_row_id
      else
        @user_id = user['id']
      end
      new_game
      @insert_turn = @db.prepare("INSERT INTO turns VALUES(null,?,?,?,?)")
    end
    
    attr_reader :name, :wins, :losses, :draws, :user_id, :game_id
    
    # Creates a new game and restores the values
    def new_game
      @wins = 0
      @losses = 0
      @draws = 0
      @db.execute("INSERT INTO games VALUES(null,?,?)", [@user_id, 
        Time.now.to_i])
      @game_id = @db.last_insert_row_id
    end
    
    # Add a win
    def win!
      @wins += 1
      insert_record
    end
    
    # Add a loss
    def lose!
      @losses += 1
      insert_record
    end
    
    # Add a draw
    def draw!
      @draws += 1
      insert_record
    end
    
    private
    # Insert a record into the database
    def insert_record
      values = [@wins, @draws, @losses, @game_id]
      @insert_turn.execute values
    end
end
