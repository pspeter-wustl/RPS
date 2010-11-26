require 'app/controllers/thinker'

describe Thinker do
  before(:each) do
    @thinker = Thinker.new({})
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
    (0..50).each do |i| 
      @thinker.add(rand(3), rand(3))
      ([0,1,2].include? @thinker.think).should be true
    end
  end
end
