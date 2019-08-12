# Anagram Tracker

## Description
The project is to build an API that allows fast searches for [anagrams](https://en.wikipedia.org/wiki/Anagram). This project is made up of 2 database tables: the dictionary, and the corpus of words, which starts out empty. Users can post new words, and if they exist in the English dictionary, they will be added to the corpus. Once words are added to the corpus, they can be displayed with their anagrams.

## Production URL

This API is available in production at:

## Instructions

### How to setup:
    git clone git@github.com:jalena-penaligon/anagram-api.git
    cd anagram-api
    bundle
    rake db:{create,migrate,seed}
    rails s

### Available Endpoints:
  #### GET /words
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


  #### POST /words
      Headers:
        Content-Type: application/json
        Accept: application/json

      Body:
      {
        "words": ["read", "dear", "dare"]
      }

      Sample Response:
        Status: 201 Created

  #### GET /anagrams/:word
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

  #### DELETE /words/:word
      Sample Response:
        204 No Content

  #### DELETE /words
      Sample Response:
        204 No Content

  #### GET /word_count
      Sample Response:
        {
          "statistics": {
              "total_words": 21,
              "min_length": 2,
              "max_length": 12,
              "average_length": "4.9"
          }
        }

  #### GET /anagram_matcher
        Body:
          { "words": ["read", "dear", "dare"] }

        Sample Response:
          { "are_anagrams?": true }

  #### GET /anagram_groups
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

  #### DELETE words/anagrams/:word
        Sample Response: 204 No Content
