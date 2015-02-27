require 'sinatra'
require 'httparty'

def get_joke
  json = HTTParty.get("http://api.icndb.com/jokes/random") # retrieves JSON
  json["value"]["joke"] # returns just the joke
end

get '/' do
  joke = get_joke
  erb :home, locals: { joke: joke }
end

# this could be simplified to:

# get '/' do
  # erb :home, locals: { joke: get_joke }
# end
