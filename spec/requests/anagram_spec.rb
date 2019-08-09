require 'rails_helper'

describe "Anagrams API" do
  before(:each) do
    dear = DictionaryWord.create!(word: "dear", key: "ader")
    dare = DictionaryWord.create!(word: "dare", key: "ader")
    read = DictionaryWord.create!(word: "read", key: "ader")
    read = DictionaryWord.create!(word: "adder", key: "adder")
    read = DictionaryWord.create!(word: "adred", key: "adder")
    read = DictionaryWord.create!(word: "dread", key: "adder")
    read = DictionaryWord.create!(word: "dared", key: "adder")
    read = DictionaryWord.create!(word: "readd", key: "adder")
  end
  it 'can get anagrams of a word' do
    dear = Word.create!(name: "dear", key: "ader")
    dare = Word.create!(name: "dare", key: "ader")
    read = Word.create!(name: "read", key: "ader")

    get "/anagrams/read"
    expect(response).to be_successful

    words = JSON.parse(response.body)

    expect(words["anagrams"].count).to eq(2)
    expect(words["anagrams"][0]).to eq("dare")
    expect(words["anagrams"][1]).to eq("dear")
  end

  it 'can request anagrams with a limit' do
    body = {"words": ["read", "dear", "dare"] }
    post "/words", params: body

    get "/anagrams/dare?limit=1"
    words = JSON.parse(response.body)

    expect(words["anagrams"].count).to eq(1)
  end

  it 'will return an empty array for a word that has no anagrams' do
    get "/anagrams/zyxwv"
    words = JSON.parse(response.body)

    expect(words["anagrams"].count).to eq(0)
  end
end
