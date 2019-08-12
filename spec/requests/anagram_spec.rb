require 'rails_helper'

describe "Anagrams API" do
  before(:each) do
    dear = Word.create!(name: "dear", key: "ader")
    dare = Word.create!(name: "dare", key: "ader")
    read = Word.create!(name: "read", key: "ader")
    drae = Word.create!(name: "Drae", key: "ader")
    adder = Word.create!(name: "adder", key: "adder")
    dread = Word.create!(name: "dread", key: "adder")
  end
  it 'can get anagrams of a word' do
    get "/anagrams/read"
    expect(response).to be_successful

    words = JSON.parse(response.body)

    expect(words["anagrams"].count).to eq(2)
    expect(words["anagrams"][0]).to eq("dare")
    expect(words["anagrams"][1]).to eq("dear")
  end

  it 'can request anagrams with a limit' do
    get "/anagrams/dare?limit=1"
    words = JSON.parse(response.body)

    expect(words["anagrams"].count).to eq(1)
  end

  it 'will return an empty array for a word that has no anagrams' do
    get "/anagrams/zyxwv"
    words = JSON.parse(response.body)

    expect(words["anagrams"].count).to eq(0)
  end

  it 'can optionally include or exclude proper nouns' do
    get "/anagrams/read?nouns=true"
    words = JSON.parse(response.body)

    expect(words["anagrams"].count).to eq(3)
    expect(words["anagrams"].first).to eq("Drae")

    get "/anagrams/read?nouns=false"
    words = JSON.parse(response.body)

    expect(words["anagrams"].count).to eq(2)
    expect(words["anagrams"].first).to eq("dare")
  end

  it 'can return words with the most anagrams' do
    get "/most_anagrams"
    words = JSON.parse(response.body)
  
    expect(words["most_anagrams"].count).to eq(4)
    expect(words["most_anagrams"][0]).to eq("Drae")
    expect(words["most_anagrams"][1]).to eq("dare")
    expect(words["most_anagrams"][2]).to eq("dear")
    expect(words["most_anagrams"][3]).to eq("read")
  end
end
