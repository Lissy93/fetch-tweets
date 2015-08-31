expect = require('chai').expect

fetchTweets = require '../index'

twitterKeys = {
  consumer_key : 'XXXXXXXXXXXXXXXXXXXXXXXXX'
  consumer_secret : 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
}

describe 'Check the modules basic functionality', ()->

  it 'Should create a new instance of fetch-tweets with twitter keys and default second param', ()->
    newInstance = new fetchTweets(twitterKeys)
    expect(newInstance).to.be.an.instanceof(fetchTweets)
    expect(newInstance.credentials).equal(twitterKeys)
    expect(newInstance.shouldFormatResults).equal true

  it 'Should create a new instance of fetch-tweets with 2 params passed to constructor', ()->
    newInstance2 = new fetchTweets(twitterKeys, false)
    expect(newInstance2).to.be.an.instanceOf(fetchTweets)
    expect(newInstance2.credentials).equal(twitterKeys)
    expect(newInstance2.shouldFormatResults).to.be.a('boolean')
    expect(newInstance2.shouldFormatResults).equal(false)




