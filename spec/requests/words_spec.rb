require 'rails_helper'

describe "Words API" do
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
    dear = DictionaryWord.create!(word: "dear")
    dare = DictionaryWord.create!(word: "dare")
    read = DictionaryWord.create!(word: "read")

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
end
