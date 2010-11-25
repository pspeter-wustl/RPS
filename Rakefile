require 'sqlite3'

namespace :db do
  desc "Create the database"
  task :create do
    db = SQLite3::Database.new('db/data.sqlite3')
    db.execute('CREATE TABLE users(id integer primary key autoincrement, 
      name text)')
    db.execute('CREATE TABLE games(id integer primary key autoincrement,
      search integer, history integer, analyze_user integer, 
      analyze_computer integer, user_id integer, timestamp integer)')
    db.execute('CREATE TABLE turns(id integer primary key autoincrement,
      wins integer, draws integer, losses integer, game_id integer)')
  end
  
  desc "Reset the database"
  task :reset do
    db = SQLite3::Database.new('db/data.sqlite3')
    db.execute('DROP TABLE users')
    db.execute('DROP TABLE games')
    db.execute('DROP TABLE turns')
    Rake::Task['db:create'].invoke
  end
end

desc "Run all the tests"
task :test do
  puts `rspec test/*.spec`
  Rake::Task['db:reset'].invoke
end
