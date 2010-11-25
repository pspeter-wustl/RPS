require 'app/models/profile'

describe Profile do
  before(:all) do
    @db = SQLite3::Database.new("db/data.sqlite3")
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
  
  it "should have enter the name in the database" do
    user = @db.get_first_row("SELECT id FROM users WHERE name='user'")
    user.should_not eql(nil)
  end
end
