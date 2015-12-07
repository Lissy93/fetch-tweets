request = require 'request'
querystring = require 'querystring'

class FetchTweets

  shouldFormatResults = null

  constructor: (@credentials, @shouldFormatResults = true) ->
    shouldFormatResults = @shouldFormatResults


  # Fetches the data from given URL from Twitter
  makeRequest = (url, credentials, callback) ->
    oauth = {
      callback: '/'
      consumer_key: credentials.consumer_key
      consumer_secret: credentials.consumer_secret
    }
    request {
      url: url
      json: true
      oauth: oauth
    },(error, response, body)->
      if !error and response.statusCode == 200
        callback (body)


  # Processes the results to get rid of not needed data
  formatResults = (twitterResults) ->
    if !shouldFormatResults
      return twitterResults
    tweetObjescts = []
    for rawTweetObject in twitterResults.statuses
      tweetObjescts.push({
        'date': rawTweetObject.created_at,
        'body': rawTweetObject.text
        'location': {
          'geo' : rawTweetObject.geo
          'coordinates' : rawTweetObject.coordinates
          'place' : rawTweetObject.place
        }
        'retweet-count' : rawTweetObject.retweet_count
        'favorited-count' : rawTweetObject.favorite_count
        'lang' : rawTweetObject.lang
      })
    tweetObjescts


  byTopic: (params = '', cb) ->
    if typeof params is 'string'
      urlParams = 'q='+params+'&count=100'
    else if typeof params is 'object'
      urlParams = querystring.stringify(params)

    url = 'https://api.twitter.com/1.1/search/tweets.json?'+urlParams
    makeRequest url, @credentials, (results) ->
      cb formatResults(results)

module.exports = FetchTweets



