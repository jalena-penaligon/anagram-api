require 'rails_helper'

describe "Anagram Matcher API" do
  before(:each) do
    dear = Word.create!(name: "dear", key: "ader")
    dare = Word.create!(name: "dare", key: "ader")
    read = Word.create!(name: "read", key: "ader")
    dread = Word.create!(name: "dread", key: "adder")
  end

  it 'can confirm if a set of words are anagrams of one another' do
    body = {"words": ["read", "dear", "dare"] }
    get "/anagram_matcher", params: body

    words = JSON.parse(response.body)

    expect(words["are_anagrams?"]).to eq(true)
  end

  it 'can confirm if a set of words are not anagrams of one another' do
    body = {"words": ["read", "dear", "dread"] }
    get "/anagram_matcher", params: body

    words = JSON.parse(response.body)

    expect(words["are_anagrams?"]).to eq(false)
  end

  it 'will return false if a word is not in the corpus' do
    body = {"words": ["read", "dear", "dreary"] }
    get "/anagram_matcher", params: body

    words = JSON.parse(response.body)

    expect(words["are_anagrams?"]).to eq(false)
  end
end
