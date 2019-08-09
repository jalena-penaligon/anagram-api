require 'rails_helper'

describe "Anagrams API" do
  before(:each) do
    dear = DictionaryWord.create!(word: "dear")
    dare = DictionaryWord.create!(word: "dare")
    read = DictionaryWord.create!(word: "read")
  end
  it 'can get anagrams of a word' do
    dear = Word.create!(name: "dear")
    dare = Word.create!(name: "dare")
    read = Word.create!(name: "read")
    aw_1 = AnagramWord.create(word_id: read.id, anagram_id: dear.id, anagram_name: "dear")
    aw_2 = AnagramWord.create(word_id: read.id, anagram_id: dare.id, anagram_name: "dare")

    get "/anagrams/read"
    expect(response).to be_successful

    words = JSON.parse(response.body)

    expect(words["anagrams"].count).to eq(2)
    expect(words["anagrams"][0]).to eq("dare")
    expect(words["anagrams"][1]).to eq("dear")
  end

  it 'can add words to the corpus, then view their anagrams' do
    body = {"words": ["read", "dear", "dare"] }
    post "/words", params: body

    get "/anagrams/dare"
    words = JSON.parse(response.body)

    expect(words["anagrams"].count).to eq(2)
    expect(words["anagrams"][0]).to eq("dear")
    expect(words["anagrams"][1]).to eq("read")
  end

  it 'can request anagrams with a limit' do
    body = {"words": ["read", "dear", "dare"] }
    post "/words", params: body

    get "/anagrams/dare?limit=1"
    words = JSON.parse(response.body)

    expect(words["anagrams"].count).to eq(1)
  end
end
