require 'app/models/profile'

describe Profile do
  before(:all) do
    puts "Database needs to be reset for all the tests to pass"
    puts "Run rake db:reset to reset the database"
    @db = SQLite3::Database.new("db/data.sqlite3")
    @db.results_as_hash = true
    @db.type_translation = true
  end
  
  before do
    @profile = Profile.new("User")
  end
  
  it "should have a name" do
    @profile.name.should eql("user")
  end
  
  it "should record wins" do
    @profile.win!
    @profile.wins.should eql(1)
  end
  
  it "should record losses" do
    @profile.lose!
    @profile.losses.should eql(1)
  end
  
  it "should record draws" do
    @profile.draw!
    @profile.draws.should eql(1)
  end
  
  it "should have entered the name in the database" do
    user = @db.get_first_row("SELECT id FROM users WHERE name='user'")
    user.should_not eql(nil)
    user['id'].should eql(@profile.user_id)
  end
  
  it "should track the game_id" do
    user_id = @db.get_first_row("SELECT id FROM users WHERE name='user'")['id']
    game_id = @db.get_first_row("SELECT id FROM games WHERE user_id=? ORDER BY
      id DESC", [user_id])['id']
    game_id.should eql(@profile.game_id)
  end
  
  it "should insert turns into the database" do
    @profile.win!
    @profile.win!
    @profile.lose!
    @profile.draw!
    expect = [[1,0,0],[2,0,0],[2,1,0],[2,1,1]]
    @db.results_as_hash = false
    turns = @db.execute("SELECT wins, losses, draws FROM turns WHERE game_id=?", 
      [@profile.game_id])
    expect.should eql(turns)
  end
  
  it "should have a user record" do
    expect = {:wins => 3, :draws => 2, :losses => 2}
    expect.should eql(@profile.user_record)
  end
  
  it "should have a global record" do
    expect = {:wins => 3, :draws => 2, :losses => 2}
    expect.should eql(@profile.global_record)
  end
end
