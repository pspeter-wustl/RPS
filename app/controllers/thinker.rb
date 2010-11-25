#!/usr/bin/ruby

# The Thinker class is responsible for maintaining history for both the
# computer and user as well as analyzing the history to determine what move to
# make. This is the main class of the application.
class Thinker
  # Constructor, takes a max search pattern length and a max history to store
  def initialize(max_search, max_history)
    @user = []
    @computer = []
    @max_search = max_search
    @max_history = max_history
  end
end
