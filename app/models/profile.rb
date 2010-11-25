#!/usr/bin/ruby
require 'sqlite3'

# The Profile class is used to track information for a profile including their
# name and win/loss statistics.
class Profile
    # Constructor, takes the name of a user and instantiates the values
    # for a game. The profile also mantains a connection to the database.
    def initialize(name,args)
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
      @args = args << @user_id
      new_game
      @insert_turn = @db.prepare("INSERT INTO turns VALUES(null,?,?,?,?)")
    end
    
    attr_reader :name, :wins, :losses, :draws, :user_id, :game_id
    
    # Creates a new game and restores the values
    def new_game
      @wins = 0
      @losses = 0
      @draws = 0
      @db.execute("INSERT INTO games VALUES(null,?,?,?,?,?,?)", @args + 
        [Time.now.to_i])
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
    
    # Returns the game records as a hash
    def game_record
      {:wins => @wins, :draws => @draws, :losses => @losses}
    end
    
    # Returns the user results of the user as a hash
    def user_record
      values = {:wins => 0, :draws => 0, :losses => 0}
      @db.execute("SELECT turns.wins, turns.draws, turns.losses FROM 
        users, games, turns WHERE users.id = games.user_id AND 
        games.id = turns.game_id AND users.id = ? GROUP BY turns.game_id", 
        [@user_id]).each do |row|
        values[:wins] += row[0]
        values[:draws] += row[1]
        values[:losses] += row[2]
      end
      values
    end
    
    # Returns the global results of the users as a hash
    def global_record
      values = {:wins => 0, :draws => 0, :losses => 0}
      @db.execute("SELECT wins, draws, losses FROM turns 
        GROUP BY game_id").each do |row|
        values[:wins] += row['wins']
        values[:draws] += row['draws']
        values[:losses] += row['losses']
      end
      values
    end
    
    private
    # Insert a record into the database
    def insert_record
      values = [@wins, @draws, @losses, @game_id]
      @insert_turn.execute values
    end
end
