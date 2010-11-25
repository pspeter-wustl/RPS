require 'app/controllers/engine'

describe Engine do
  before(:each) do
    @engine = Engine.new("user",{})
  end
  
  it "should handle input" do
    @engine.respond_to?(:handle_input).should be true
  end
  
  it "should handle rock" do
    @engine.handle_input(:rock).should_not eql("Invalid input")
  end
  
  it "should handle paper" do
    @engine.handle_input(:paper).should_not eql("Invalid input")
  end
  
  it "should handle scissors" do
    @engine.handle_input(:scissors).should_not eql("Invalid input")
  end
  
  it "should handle help" do
    @engine.handle_input(:help).should_not eql("Invalid input")
  end
  
  it "should handle game results" do
    @engine.handle_input(:game).should_not eql("Invalid input")
  end
  
  it "should handle global" do
    @engine.handle_input(:global).should_not eql("Invalid input")
  end
  
  it "should handle user" do
    @engine.handle_input(:user).should_not eql("Invalid input")
  end
  
  it "should handle new" do
    @engine.handle_input(:reset).should_not eql("Invalid input")
  end
end
