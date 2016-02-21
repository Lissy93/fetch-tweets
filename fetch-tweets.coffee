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
        'location': prepareLocation(rawTweetObject)
        'retweet-count' : rawTweetObject.retweet_count
        'favorited-count' : rawTweetObject.favorite_count
        'lang' : rawTweetObject.lang
      })
    tweetObjescts

  # Get location
  prepareLocation = (body) ->
    location =
      place_name: '_'
      location: { lat: 0.0000000, lng: 0.0000000 }

    # Check Coordinates object
    if body.coordinates?
      location.location.lat = body.coordinates.coordinates[1]
      location.location.lng = body.coordinates.coordinates[0]
    else if body.geo?
      location.location.lat = body.geo.coordinates[0]
      location.location.lng = body.geo.coordinates[1]

    # Check for place name
    if body.place?
      location.place_name = body.place.name
    else if body.user?
      location.place_name = body.user.location
    location

  formatTrends = (preResults) ->
    results = []
    for item in preResults[0].trends
      results.push {trend: item.name, volume: item.tweet_volume}
    results



  byTopic: (params = '', cb) ->

    if typeof params is 'string'
      urlParams = 'q='+params+'&count=100'
    else if typeof params is 'object'
      urlParams = querystring.stringify(params)

    url = 'https://api.twitter.com/1.1/search/tweets.json?'+urlParams
    makeRequest url, @credentials, (results) ->
      cb formatResults(results)


  trending: (placeId, cb) ->
    trendingUrl = 'https://api.twitter.com/1.1/trends/place.json'+'?id='+placeId
    makeRequest trendingUrl, @credentials, (results) -> cb formatTrends results


  closestTrendingWoeid: (lat, long, cb) ->
    url="https://api.twitter.com/1.1/trends/closest.json?lat=#{lat}&long=#{long}"
    makeRequest url, @credentials, (results) -> cb results

    
module.exports = FetchTweets
