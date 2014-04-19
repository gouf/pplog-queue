require_relative 'main'
require 'bundler'
Bundler.require

class Check
  include PoemPoster
  def check
    user_name
    password
  end
end
c = Check.new
c.check

run PPLogQueue
