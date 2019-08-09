require 'rails_helper'

RSpec.describe AnagramWord, type: :model do
  describe 'validations' do
    it { should validate_presence_of :word_id }
    it { should validate_presence_of :anagram_id }
  end
end
