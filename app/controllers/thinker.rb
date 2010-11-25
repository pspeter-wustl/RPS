#!/usr/bin/ruby

# The Thinker class is responsible for maintaining history for both the
# computer and user as well as analyzing the history to determine what move to
# make. This is the main class of the application.
class Thinker
  # Constructor, takes a hash of arguments to use. :max_search determines the
  # max search length and defaults to 5. :max_length
  # determines the maximum data to hold in the history and defalts to 50. The 
  # last options are :analyze_user and :analyze_computer. They are responsible
  # for determining if the thinker should take into account both computer and
  # human history. Both valuse default to true
  def initialize(args)
    @user = []
    @computer = []
    # :max_search check
    if args.has_key? :max_search
      @max_search = args[:max_search]
    else
      @max_search = 5
    end
    # :max_history check
    if args.has_key? :max_history
      @max_history = args[:max_history]
    else
      @max_history = 50
    end
    # :analyze_user check
    if args.has_key? :analyze_user
      @analyze_user = args[:analyze_user]
    else
      @analyze_user = true
    end
    # :analyze_computer check
    if args.has_key? :analyze_computer
      @analyze_computer = args[:analyze_computer]
    else
      @analyze_computer = true
    end
  end
  
  attr_reader :user, :computer, :max_search, :max_history
  
  # Adds history
  def add(user, computer)
    @user << user
    @computer << computer
  end
  
  # Returns the argument array for Profile to use in storing games in the
  # database and convert the booleans to 0 and 1
  def args
    [@max_search, @max_history, bool(@analyze_user), bool(@analyze_computer)]
  end
  
  # Returns what move to make for the computer based on the analysis. The
  # method creates a Mind object to hold an exponential smoothed vector in RPS
  # space. It goes through the history and checks whether or not to add to the
  # mind. If the length of history is less than 2 it returns a random value.
  def think
    # Return if there just isn't enough history
    return rand(3) if @user.size < 2
    # Set up the mind
    mind = Mind.new
    # Set up the hashes
    user = {} if @analyze_user
    comp = {} if @analyze_computer
    # Set up the patterns
    upattern, cpattern = patterns
    # Loop to the last value
    (0...(@user.size-1)).each do |i|
    end
  end
  
  private
  # Converts a boolean to 0 or 1 for the database
  def bool(value)
    return 1 if value
    0
  end
  
  # Creates the patterns for user and computer
  def patterns
  end
end
