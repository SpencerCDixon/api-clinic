require 'sinatra'
require 'httparty'
require 'json'
require 'pry'

def get_joke
  json = HTTParty.get("http://api.icndb.com/jokes/random") # retrieves JSON
  json["value"]["joke"] # returns just the joke
end

# send home page to jokes
get '/' do
  redirect '/jokes'
end

get '/jokes' do
  joke = get_joke
  erb :home, locals: { joke: joke }
end

# this could be simplified to:
# get '/' do
  # erb :home, locals: { joke: get_joke }
# end
#
# or
#
# get '/' do
#   @joke = get_joke
#   # now we need to reference joke in view as instance variable
#
#   erb :home
# end

# make a JSON GET request for a new joke

get '/new-joke.json' do
  content_type :json

  { joke: get_joke }.to_json
end

##########################
##### BREWERY API ########
##########################

