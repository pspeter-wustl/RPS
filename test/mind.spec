require 'app/models/mind'

describe Mind do
  before(:each) do
    @mind = Mind.new()
  end
  
  it "should take a value" do
    @mind.add 3, 5, 50, 0
  end 
  
  it "should calculate the appropriate weight" do
    @mind.add 3, 5, 50, 0
    @mind.rock.should eql(0.3)
  end
  
  it "should return the approriate max weight" do
    @mind.max_weights.should eql([0,1,2])
    @mind.add 3, 5, 50, 0
    @mind.max_weights.should eql([0])
    @mind.add 3, 5, 50, 1
    @mind.max_weights.should eql([1])
  end
end
