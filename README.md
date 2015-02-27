### API Clinic

**Resources:**

*  [Good website to find different API's](https://www.apitools.com/apis)
*  [Dotenv Gem](https://github.com/bkeepers/dotenv)
*  [HTTP Party Gem](https://github.com/jnunemaker/httparty)
*  [Chuck Norris API](http://www.icndb.com/api/)

When we use API's all we are doing is hitting a specific route on another
persons web app.  By doing that we are able to query data in their Database or
even add data to it.

Generally, most API's require that you send along an API key with the request,
that way they can track how many times you are using their API (and know who is
using the api).  However not all
API's will require a key.  To start off lets use the Chuck Norris API that
doesn't require a key.

```ruby
gem install httparty # installs httparty gem

pry # opens up an irb session that will have text highlighting

require 'httparty' # requires the http libary

HTTParty.get("http://api.icndb.com/jokes/random") # makes call to the api
```

What we are doing in this quick example is making a GET request to the
`/jokes/random` route of this persons website.  The Get request will return us
a JSON object that looks something like this:

```ruby
[2] pry(main)> HTTParty.get("http://api.icndb.com/jokes/random")

=> {"type"=>"success",
 "value"=>
  {"id"=>137,
   "joke"=>"Tom Clancy has to pay royalties to Chuck Norris because &quot;The Sum of All Fears&quot; is the name of Chuck Norris' autobiography.",
   "categories"=>[]}}
```

We could now convert this to our own Sinatra app:
```ruby
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

get '/' do
  erb :home, locals: { joke: get_joke }
end
```

Now inside our `home.erb` file we will have a local variable that is associated
with a Chuck Norris joke.  Every time we refresh the page a new Chuck Norris
joke will be generated.



