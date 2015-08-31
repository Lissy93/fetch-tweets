# fetch-tweets
> A simple to use, feature-rich, tested node module for fetching Tweets from the Twitter API.


### Install 
```npm install fetch-tweets --save```

### Set up
Create a new Twitter app [here](https://apps.twitter.com/app/new) to get your consumer key and secret.

Include the following code in your file. 

```javascript
var FetchTweets = require('fetch-tweets'); // Include the module

// Specify Twitter keys (preferably in an external .gitignore'd file)
var apiKeys = {
    consumer_key : 'XXXXXXXXXXXXXXXXXXXXXXXXX',
    consumer_secret : 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
};

// Create a new object and pass in keys and optional additional options (see below)
var fetchTweets = new FetchTweets(apiKeys); 
```
The above code: includes the fetch-tweets module, creates a new instance and passes in your Twitter API keys.


## Fetching Tweets by keyword(s)
There are two methods of selecting Tweets by keyword, using Twitter search API. 
* Single paramater string containing the search term
* Single paramater JSON object containing options

### Simple example
```javascript
fetchTweets.byTopic('JavaScript', function(results){
   console.log(results); // Do whatever with the results
});
```
There are a series query operators that can be used inside this string parameter, such as fetching Tweets containg multiple keywords. 
To view a list of query operators click here.

### Specifying more options
You can also search for Tweets by passing in a JSON object containing options set by the Twitter API. There is an extensive list of options such as dates, locations, languages and popularity. For example:

```javascript
var options = {
  q: 'banana',
  lang: 'en',
  result_type: 'popular',
  count: 5,
}

fetchTweets.byTopic(options, function(results){
   console.log(results); // Do whatever with the results
});
```

View the full list of what you can pass in as options [here in the Twitter documentation](https://dev.twitter.com/rest/reference/get/search/tweets)

## The Results
There are two options for how you'd like your results returned:
* Formatted Results - just the useful stuff *(default)*
* Full Results - everything that is returned by the Twitter API

### Formated Results (just the usefull stuff)
This is default, so you don't need to do anything different than above

Results will be returned in the following format:
```javascript
[
    {   date: 'Sun Aug 30 15:55:09 +0000 2015',
        body: 'JavaScript is just so totally awesome',
        location: { geo: null, coordinates: null, place: null },
        'retweet-count': 23952,
        'favorited-count': 0,
        lang: 'en' },
    {   date: 'Sun Aug 30 15:55:09 +0000 2015',
        body: 'Ony one thing more awesome than JavaScript and that's CoffeeScript!!',
        location: { geo: null, coordinates: null, place: null },
        'retweet-count': 0,
        'favorited-count': 0,
        lang: 'en' },
    {   date: 'Sun Aug 30 15:55:08 +0000 2015',
        body: 'And the one thing more awesome than CoffeeScript, Coffee!!!!',
        location: { geo: null, coordinates: null, place: null },
        'retweet-count': 0,
        'favorited-count': 0,
        lang: 'en'
    }
]
```


### Full Results
If you would like the full results returned by the Twitter API, then you can specify the second parameter as false when creating the fetchTweets object:
```javascript
var FetchTweets = require('fetch-tweets');
var fetchTweets = new FetchTweets(apiKeys, false);
```

You can view an example of the format of these results [here, on the Twitter website](https://dev.twitter.com/rest/reference/get/search/tweets)

## Tests
fetch-tweets uses Mocha, Chai, Sinon and Istanbul to form it's testing environment.

To run all tests: ```npm test```

Summary of test results will be outputed to the console, more detailed results are generated and saved in the reports directory 

## Building
fetch-tweets uses gulp to prepare all the files

Run ```gulp build``` to build

Run ```gulp test``` to test

Run ```gulp``` To clean directory, build, test, and watch for changes rebuilding when a file is modified


License
----
MIT © [Alicia Sykes](http://aliciasykes.com)



