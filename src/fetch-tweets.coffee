request = require 'request'
qs = require 'querystring'

class FetchTweets
  constructor: (@credentials) ->

  makeRequest = (url, credentials, callback) ->
    console.log (credentials)
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
        #callback processResults(body)
        console.log(body)
      return
    return

  talk: ->
    url = 'https://api.twitter.com/1.1/search/tweets.json?q=hello'
    makeRequest url, @credentials, (results) ->
      console.log results
      return



module.exports = FetchTweets