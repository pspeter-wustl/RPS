#!/usr/bin/ruby
# The profile class is used to track information for a profile including their
# name and win/loss statistics.

require 'sqlite3'

class Profile
    # Constructor, takes the name of a user
    def initialize(name)
      @db = SQLite3::Database.new('db/stats.sqlite3')
      
    end
end
