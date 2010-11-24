require 'app/models/profile'

describe Profile do
  before do
    profile = Profile.new("Phips")
  end
  
  it "should have a name" do
    profile.name.should eql("Phips")
  end
end
