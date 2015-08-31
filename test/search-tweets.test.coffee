# Testing frameworks and tools
expect = require('chai').expect
sinon = require('sinon')

# Modules to test
fetchTweets = require '../index'
twitterKeys = {
  consumer_key : 'XXXXXXXXXXXXXXXXXXXXXXXXX',
  consumer_secret : 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
};

# Fake data to use as sinon stubs
fakeData1   = require './fake-data/search-tweets-fake-data1'
fakeData2   = require './fake-data/search-tweets-fake-data2'
fakeData3   = require './fake-data/search-tweets-fake-data3'

# Set up sinon stubs
ftModuleShort  = new fetchTweets(twitterKeys)
ftModuleLong   = new fetchTweets(twitterKeys, false) # will return full output

callback1 = sinon.stub(ftModuleShort, "byTopic")
callback1.withArgs({q: 'awesome', count: 3}).returns(fakeData1);
callback1.withArgs('banana').returns(fakeData3);

callback2 = sinon.stub(ftModuleLong, "byTopic")
callback2.withArgs({q: 'javascript', count: 5}).returns(fakeData2);


describe 'Check the search tweets methods work as they should', ()->

  it 'Should accept a json object with Twtter options', ()->
    expect(callback1({q: 'awesome', count: 3})).equal(fakeData1)

  it 'Should return full output for specified object', ()->
    expect(callback2({q: 'javascript', count: 5})).equal(fakeData2)

  it 'Should also accept a plain string input', ()->
    expect(callback1('banana')).equal(fakeData3)
