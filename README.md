### API Clinic

Resources:

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
gem install httparty

pry

require 'httparty'

HTTParty.get("http://api.icndb.com/jokes/random")
```



