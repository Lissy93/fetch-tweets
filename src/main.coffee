FetchTweets = require './fetch-tweets'
config = require '../examples/twitter-keys'

fetchTweets = new FetchTweets(config)

fetchTweets.byTopic 'banana', (results) ->
  console.log results



