# Anagram Tracker

## Description
The project is to build an API that allows fast searches for [anagrams](https://en.wikipedia.org/wiki/Anagram). This project is made up of 2 database tables: the dictionary, and the corpus of words, which starts out empty. Users can post new words, and if they exist in the English dictionary, they will be added to the corpus. Once words are added to the corpus, they can be displayed with their anagrams.

## Production URL

This API is available in production at: http://anagrams.us-east-2.elasticbeanstalk.com

## Instructions

### How to setup:
    git clone git@github.com:jalena-penaligon/anagram-api.git
    cd anagram-api
    bundle
    rake db:{create,migrate,seed}
    rails s

### Available Endpoints:
  #### GET http://anagramsapi.us-east-2.elasticbeanstalk.com/words
      Sample Response:
      [{
        id: 25,
        name: "dear",
        char_count: 4,
        key: "ader"
      },
      {
        id: 26,
        name: "read",
        char_count: 4,
        key: "ader"
      },
      {
        id: 27,
        name: "dare",
        char_count: 4,
        key: "ader"
      }]


  #### POST http://anagramsapi.us-east-2.elasticbeanstalk.com/words
      Headers:
        Content-Type: application/json
        Accept: application/json

      Body:
      {
        "words": ["read", "dear", "dare"]
      }

      Sample Response:
        Status: 201 Created

  #### GET http://anagrams.us-east-2.elasticbeanstalk.com/anagrams/:word
        Optional Params:
          limit=1 : Only returns the number of specified records
          nouns=true : Returns all anagrams
          nouns=false : Returns only anagrams that are not proper nouns

        Sample Response:
        {
          "anagrams": [
              "dare",
              "dear"
          ]
        }

  #### DELETE http://anagramsapi.us-east-2.elasticbeanstalk.com/words/:word
      Sample Response:
        204 No Content

  #### DELETE http://anagramsapi.us-east-2.elasticbeanstalk.com/words
      Sample Response:
        204 No Content

  #### GET http://anagramsapi.us-east-2.elasticbeanstalk.com/word_count
      Sample Response:
        {
          "statistics": {
              "total_words": 21,
              "min_length": 2,
              "max_length": 12,
              "average_length": "4.9"
          }
        }

  #### GET http://anagramsapi.us-east-2.elasticbeanstalk.com/anagram_matcher
        Body:
          { "words": ["read", "dear", "dare"] }

        Sample Response:
          { "are_anagrams?": true }

  #### GET http://anagramsapi.us-east-2.elasticbeanstalk.com/most_anagrams
        Sample Response:
          {
            "most_anagrams": [
                "dare",
                "dear",
                "read"
            ]
          }

  #### GET http://anagramsapi.us-east-2.elasticbeanstalk.com/anagram_groups
        Sample Response:
        {
          "groups": {
              "2": [
                  [
                      "run",
                      "urn"
                  ]
              ],
              "3": [
                  [
                      "dare",
                      "dear",
                      "read"
                  ]
              ]
          }
        }

  #### DELETE http://anagramsapi.us-east-2.elasticbeanstalk.com/words/anagrams/:word
        Sample Response: 204 No Content

### Considerations:
- Currently only English words from dictionary.txt can be added to the corpus. With this constraint, it may be helpful to have an additional endpoint to post words to the dictionary, should someone want to add pop-culture related words that may not exist in the dictionary.
- By starting with an empty corpus, queries can execute quickly and efficiently. It does not exert additional load on the database searching through records that may never need to be accessed.
- In terms of user experience, some functionality could be improved in the future, such as:
    1. Importing all anagrams from the dictionary when words are added at POST /words (however this functionality would cause the provided test suite to fail)
    2. If a word does not exist in the corpus and is called at GET /anagrams/:word, it would be a more positive user experience to add that word to the corpus as well as all of their associated anagrams, rather than showing an empty array
    3. When comparing an array of words to see if they are anagrams, it will currently return false if one or more words do not exist in the corpus, even if they are actual anagrams. A better user experience could be to add those words to the corpus, and return true.
