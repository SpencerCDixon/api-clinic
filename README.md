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

To find what routes are available to call in the API you look through the
documentation.  [Here is the Chuck Norris
documentation](http://www.icndb.com/api/)

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

Now inside our `views/home.erb` file we will have a local variable that is associated
with a Chuck Norris joke.  Every time we refresh the page a new Chuck Norris
joke will be generated.


## Using API's With Keys In Sinatra: ([Taken from Helen
Hood](https://github.com/hchood/brewery_api_clinic))

### SETUP:

1. **Pick an API.**  Some good ones:  Rotten Tomatoes, Yelp, Spotify.  You can also check out sites like [apis.io](http://apis.io/) to find fun APIs.
2. **Review the documentation for your API.**
  - What data does it provide you? If you're looking at the Spotify API, for example, how would I get a list of all the songs? What attributes about each song does it provide? [**NOTE:** You can practice getting data from the API using the `curl` command on the command line.]
  - Does the API serve up JSON or XML?
  - Does the API cost money? Does it have a limit on the number of requests you can make per day?
  - Do I need an API key to access the data?
    - If so, set up an account to get your key(s).
    - How do I pass my keys to the API when I make a request? (Some APIs, such as the Beer Mapping API we'll use, allow you to pass the key directly into the URL, while others require you to pass it via the request header.)

3. **Pick a library to query your API.**  Ruby has the [Net::HTTP](http://ruby-doc.org/stdlib-2.1.5/libdoc/net/http/rdoc/Net/HTTP.html) library, but I'd recommend using a gem like [HTTParty](https://github.com/jnunemaker/httparty) (which I'll use here) or [Faraday](https://github.com/lostisland/faraday).
  - HTTParty has some nice [example apps](https://github.com/jnunemaker/httparty/tree/master/examples).

### BUILDING THE APP:
* **Set your keys.** If you need keys to access the API, use the `dotenv` gem to load your keys. (That way, you're not hardcoding your secret credentials into your app.)
  1. After creating your git repo, create a `.gitignore` file to ignore the `.env` file that we'll create to store your API credentials.

    ```no-highlight
    # create your git repo
    $ git init

    # create the .gitignore file & add .env to it
    $ echo .env > .gitignore

    # commit your changes
    $ git add -A && git commit -m "Add .env to .gitignore"
    ```

    **This step is important!!!** It is very easy to expose your secret credentials on GitHub if you forget to gitignore your `.env` file, or if you gitignore it after creating the file and committing it once. When your keys are attached to credit card information, nefarious bots can grab your credentials off of GitHub and rack up massive bills on services like AWS.

  2. Create the `.env` file and add your keys. For our [Beer Mapping API](http://beermapping.com/api/), we need a single API key.  (Some apps will provide you an ID and a key.)

    ```no-highlight
    # .env
    BEER_MAPPING_API_KEY=<your_api_key>
    ```

    Using the `dotenv` gem, we'll be able to reference this API key inside of our app like so:

    ```ruby
    ENV['BEER_MAPPING_API_KEY']
    ```

  3. Create a `.env.example` file that lists the *name(s)* of any API keys (or other credentials) that your app uses, but does *not* include your actual API key.

    ```no-highlight
    # .env.example
    BEER_MAPPING_API_KEY=
    ```

    This tells other developers who clone your app that they'll need to add their own Beer Mapping API key to the app to make it work.  They can create their own `.env` file and input their key there.

  3. Require the `dotenv` gem in your `app.rb` file.  To get access to the credentials we stored in the `.env` file, we need to require the `dotenv` gem and call `Dotenv.load`.

    ```ruby
    # app.rb
    require 'sinatra'
    require 'dotenv'

    Dotenv.load

    # ...

    ```
