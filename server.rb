require 'sinatra'
require 'httparty'
require 'json'
require 'pry'
require 'dotenv'

Dotenv.load

def get_joke
  json = HTTParty.get("http://api.icndb.com/jokes/random") # retrieves JSON
  json["value"]["joke"] # returns just the joke
end

def search_breweries_by_state(state)
  all_breweries = []
  breweries = HTTParty.get("http://beermapping.com/webservice/locstate/#{ENV["BREWERY_API_KEY"]}/#{state}")

  breweries["bmp_locations"].each do |locations|
    locations[1].each do |brewery|
      all_breweries << { name: brewery["name"] }
    end
  end
  all_breweries
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

get '/beer' do
  if params["state"]
    beers = search_breweries_by_state(params["state"])
  else
    beers = ''
  end
  erb :beer, locals: { beers: beers }
end
