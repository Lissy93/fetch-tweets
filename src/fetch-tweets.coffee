request = require 'request'
qs = require 'querystring'

endpoints = require './endpoints'

class FetchTweets
  constructor: (@credentials) ->

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

  talk: (cb) ->
    url = endpoints.FETCH_TWEETS+'?q=hello'
    makeRequest url, @credentials, (results) ->
      cb results

module.exports = FetchTweets