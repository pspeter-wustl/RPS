require 'app/controllers/thinker'

describe Thinker do
  before(:each) do
    @thinker = Thinker.new()
  end
  
  it "should take inputs" do
    @thinker.add 0, 1
  end
  
  it "should store the history" do
    @thinker.add 0, 1
    @thinker.add 1, 2
    [0,1].should eql(@thinker.user)
    [1,2].should eql(@thinker.computer)
  end
end
