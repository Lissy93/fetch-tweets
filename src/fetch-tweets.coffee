request = require 'request'
qs = require 'querystring'

endpoints = require './endpoints'

class FetchTweets
  constructor: (@credentials) ->

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
      return
    return

  # Processes the results to get rid of not needed data
  formatResults = (twitterResults) ->
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



  byTopic: (topic, cb) ->
    url = endpoints.FETCH_TWEETS+'?q='+topic
    makeRequest url, @credentials, (results) ->
      cb formatResults(results)

module.exports = FetchTweets