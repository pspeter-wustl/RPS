require 'app/controllers/thinker'

describe Thinker do
  before(:each) do
    @thinker = Thinker.new(5, 50)
  end
  
  it "should have a max search" do
    @thinker.max_search.should eql(5)
  end
  
  it "should have a max history" do
    @thinker.max_history.should eql(50)
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
  
  it "should return what to play" do
    @thinker.add 0, 1
    @thinker.add 1, 2
    [0,1,2].should have(@thinker.think)
  end
end
