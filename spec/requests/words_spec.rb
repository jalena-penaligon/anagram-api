require 'rails_helper'

describe "Words API" do
  before(:each) do
    dear = DictionaryWord.create!(word: "dear")
    dare = DictionaryWord.create!(word: "dare")
    read = DictionaryWord.create!(word: "read")
  end

  it 'can get words from the corpus' do
    dear = Word.create!(name: "dear")
    dare = Word.create!(name: "dare")
    read = Word.create!(name: "read")

    get "/words"
    expect(response).to be_successful

    words = JSON.parse(response.body)
    expect(words.count).to eq(3)
  end

  it 'can add words to the corpus' do
    body = {"words": ["read", "dear", "dare"] }
    post "/words", params: body
    expect(response).to have_http_status(201)

    expect(Word.count).to eq(3)
  end

  it 'will not add a word that does not exist in the dictionary' do
    body = {"words": ["zyxwv"] }
    post "/words", params: body
    expect(response).to have_http_status(201)

    expect(Word.count).to eq(0)
  end

  it 'can delete all words from the corpus' do
    body = {"words": ["read", "dear", "dare"] }
    post "/words", params: body
    expect(Word.count).to eq(3)

    delete "/words"
    expect(response).to have_http_status(204)
    expect(Word.count).to eq(0)
  end

  it 'can delete a single word from the corpus' do
    body = {"words": ["read", "dear", "dare"] }
    post "/words", params: body
    expect(Word.count).to eq(3)

    delete "/words/dear"
    expect(response).to have_http_status(204)
    expect(Word.count).to eq(2)
  end

  it 'deleting a single word also deletes associated anagrams' do
    body = {"words": ["read", "dear", "dare"] }
    post "/words", params: body
    expect(Word.count).to eq(3)

    delete "/words/dear"
    get "/anagrams/read"
    anagrams = JSON.parse(response.body)["anagrams"]

    expect(anagrams.count).to eq(1)
    expect(anagrams[0]).to eq("dare")
  end
end
