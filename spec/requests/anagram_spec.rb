require 'rails_helper'

describe "Anagrams API" do
  it 'can get anagrams of a word' do
    dear = Word.create!(name: "dear")
    dare = Word.create!(name: "dare")
    read = Word.create!(name: "read")

    get "/anagrams/read"
    expect(response).to be_successful
    binding.pry
    words = JSON.parse(response.body)
    expect(words.count).to eq(3)
  end
end
