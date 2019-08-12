require 'rails_helper'

describe "Anagram Groups API" do
  before(:each) do
    dear = Word.create!(name: "dear", key: "ader")
    dare = Word.create!(name: "dare", key: "ader")
    read = Word.create!(name: "read", key: "ader")
    dread = Word.create!(name: "dread", key: "adder")
    adder = Word.create!(name: "adder", key: "adder")
  end

  it 'returns all anagrams grouped by size' do
    get "/anagram_groups"

    words = JSON.parse(response.body)

    expect(words["groups"]["2"][0]).to eq(["adder", "dread"])
    expect(words["groups"]["3"][0]).to eq(["dare", "dear", "read"])
  end
end
