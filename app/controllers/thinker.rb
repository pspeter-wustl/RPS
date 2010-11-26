#!/usr/bin/ruby
require 'app/models/mind'
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
    # Make sure to only store the max history
    if @user.size > @max_history
      @user.shift
      @computer.shift
    end
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
    puts "Thinking"
    # Set up the hashes
    user = {} if @analyze_user
    comp = {} if @analyze_computer
    # Set up the patterns
    upattern, cpattern = patterns
    max = @user.size-1
    # Loop to the last value
    (0...max).each do |i|
      # Choose the minimum k value to check
      k = 0
      if @analyze_user
        k = [i + 1, upattern.size]
      else
        k = [i + 1, cpattern.size]
      end
      j, u, c = 1, @analyze_user, @analyze_computer
      while (j <= k and (u or c))
        # Check the user
        if u
          # Insert into the hash
          user[j] = [] unless user.has_key? j
          # Either insert or end user
          if @user[i - j + 1] == upattern[-1 * j]
            user[j] << @user[i + 1]
          else
            u = false
          end
        end
        # Check the computer
        if c
          # Insert into the hash
          comp[j] = [] unless comp.has_key? j
          # Either insert or end user
          if @computer[i - j + 1] == cpattern[-1 * j]
            comp[j] << @computer[i + 1]
          else
            c = false
          end
        end
        # Increment j
        j += 1
      end
    end
    # Set up the mind
    mind = Mind.new
    # Merge everything into the mind
    keys = []
    keys += user.keys if @analyze_user
    keys += comp.keys if @analyze_computer
    keys.uniq.each do |key|
      if @analyze_user and user.has_key? key
        count = user[key].size
        user[key].each do |i|
          mind.add count, key, @user.size, i
        end
      end
      if @analyze_computer and comp.has_key? key
        count = comp[key].size
        comp[key].each do |i|
          mind.add count, key, @computer.size, i
        end
      end
    end
    # Convert the weights to win
    weights = mind.max_weights.map {|i| i = (i+1) % 3}
    weights[rand(weights.size)]
  end
  
  private
  # Converts a boolean to 0 or 1 for the database
  def bool(value)
    return 1 if value
    0
  end
  
  # Creates the patterns for user and computer
  def patterns
    if @max_search > @user.size
      [@user[0...@user.size-1], @computer[0...@computer.size-1]]
    else
      [@user[-1 * @max_search..-1], @computer[-1* @max_search..-1]]
    end
  end
end
