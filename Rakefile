require 'sqlite3'

namespace :db do
  desc "Create the database"
  task :create do
    db = SQLite3::Database.new('db/stats.sqlite3')
    db.execute('CREATE TABLE users(id integer primary key autoincrement, 
      name text)')
    db.execute('CREATE TABLE games(id integer primary key autoincrement,
      user_id integer)')
    db.execute('CREATE TABLE turn(id integer primary key autoincrement,
      wins integer, draws integer, losses integer, game_id integer)')
  end
  
  desc "Reset the database"
  task :reset do
    db = SQLite3::Database.new('db/stats.sqlite3')
  end
end

desc "Run all the tests"
task :test do
  `rspec test/*.spec`
end
