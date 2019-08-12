require 'rails_helper'

describe "Words API" do
  before(:each) do
    dear = DictionaryWord.create!(word: "dear", key: "ader")
    dare = DictionaryWord.create!(word: "dare", key: "ader")
    read = DictionaryWord.create!(word: "read", key: "ader")
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

    expect(Word.find_by(name: "zyxwv")).to eq(nil)
  end

  before(:each) do
    dear = Word.create!(name: "dear", key: "ader", char_count: 4)
    dare = Word.create!(name: "dare", key: "ader", char_count: 4)
    read = Word.create!(name: "read", key: "ader", char_count: 4)
  end

  it 'can get words from the corpus' do
    get "/words"
    expect(response).to be_successful

    words = JSON.parse(response.body)
    expect(words.count).to eq(3)
  end


  it 'can delete all words from the corpus' do
    expect(Word.count).to eq(3)

    delete "/words"
    expect(response).to have_http_status(204)
    expect(Word.count).to eq(0)
  end

  it 'can delete a single word from the corpus' do
    expect(Word.count).to eq(3)

    delete "/words/dear"
    expect(response).to have_http_status(204)
    expect(Word.count).to eq(2)
  end

  it 'deleting a single word also deletes associated anagrams' do
    expect(Word.count).to eq(3)

    delete "/words/dear"
    get "/anagrams/read"
    anagrams = JSON.parse(response.body)["anagrams"]

    expect(anagrams.count).to eq(1)
    expect(anagrams[0]).to eq("dare")
  end

  it 'delete /words/anagrams will delete a word and all other anagram words' do
    delete "/words/anagrams/read"

    expect(Word.find_by(name: "read")).to eq(nil)
    expect(Word.find_by(name: "dear")).to eq(nil)
    expect(Word.find_by(name: "dare")).to eq(nil)
  end

end
describe 'Word Count API' do
  before(:each) do
    dear = Word.create!(name: "dear", key: "ader", char_count: 4)
    abstract = Word.create!(name: "abstract", key: "aabcrstt", char_count: 8)
    drive = Word.create!(name: "drive", key: "deirv", char_count: 5)
  end

  it 'get /words_count returns corpus stats' do
    get "/word_count"
    expect(response).to be_successful

    words = JSON.parse(response.body)["statistics"]
    expect(words["total_words"]).to eq(3)
    expect(words["min_length"]).to eq(4)
    expect(words["max_length"]).to eq(8)
    expect(words["average_length"]).to eq("5.67")
  end
end
