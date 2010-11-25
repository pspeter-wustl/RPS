require 'app/models/profile'

describe Profile do
  before(:all) do
    db = SQLite3::Database.new("db/stats.sqlite3")
  end
  
  before do
    profile = Profile.new("Phips")
  end
  
  it "should have a name" do
    profile.name.should eql("Phips")
  end
  
  it "should record wins" do
    profile.win!
    profile.wins.should eql(1)
  end
  
  it "should record losses" do
    profile.lose!
    profile.loses.should eql(1)
  end
  
  it "should record draws" do
    profile.draw!
    profile.drawes.should eql(1)
  end
  
  it "should have enter the name in the database" do
    db.get_first_value("SELECT COUNT(*) FROM USERS WHERE name='Phips'").should(
      eql(1))
  end
end
