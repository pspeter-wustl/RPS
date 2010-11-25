require 'app/controllers/engine'

describe Engine do
  before(:each) do
    @engine = Engine.new()
  end
  
  it "should handle input" do
    @engine.respond_to?(:handle_input).should be true
  end
  
  it "should handle rock" do
    @engine.handle_input("Rock").should_not eql("Invalid input")
    @engine.handle_input("rock").should_not eql("Invalid input")
  end
  
  it "should handle paper" do
    @engine.handle_input("Paper").should_not eql("Invalid input")
    @engine.handle_input("paper").should_not eql("Invalid input")
  end
  
  it "should handle scissors" do
    @engine.handle_input("Scissors").should_not eql("Invalid input")
    @engine.handle_input("scissors").should_not eql("Invalid input")
  end
  
  it "should handle help" do
    @engine.handle_input("help").should_not eql("Invalid input")
  end
  
  it "should handle results" do
    @engine.handle_input("results").should_not eql("Invalid input")
  end
  
  it "should handle global" do
    @engine.handle_input("global").should_not eql("Invalid input")
  end
  
  it "should handle new" do
    @engine.handle_input("new").should_not eql("Invalid input")
  end
end
