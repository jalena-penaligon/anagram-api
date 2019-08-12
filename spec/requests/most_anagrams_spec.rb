require 'rails_helper'

describe "Most Anagrams API" do
  before(:each) do
    dear = Word.create!(name: "dear", key: "ader")
    dare = Word.create!(name: "dare", key: "ader")
    read = Word.create!(name: "read", key: "ader")
    drae = Word.create!(name: "Drae", key: "ader")
    adder = Word.create!(name: "adder", key: "adder")
    dread = Word.create!(name: "dread", key: "adder")
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
