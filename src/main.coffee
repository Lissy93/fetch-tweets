FetchTweets = require './fetch-tweets'
config = {
  consumer_key : 'P7vhOiDbJWwNbEAb4OAkjNvvA'
  consumer_secret : 'OJh4gToZW2P37011GRP7zwChyAbAnzUF5teck0hnQZqvaPlj8M'
}
fetchTweets = new FetchTweets(config)

fetchTweets.byTopic 'hello', (results) ->
  console.log results

