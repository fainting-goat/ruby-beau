require 'rails_helper'

RSpec.describe FileParser do
  let(:parsed_file) {
    [["Beau", "is", "the", " best", "best", "best", " dog\n"],
     ["he", "is", "just", " super", "super", " super", "great"]]
  }

  describe 'get_file_contents' do
    let(:filename) { 'spec/fixtures/test_file.txt' }
    let(:content) {}

    it 'returns the file contents' do
      expect(get_file_contents(filename)).to eq(parsed_file)
    end
  end

  describe 'clean_contents' do
    let(:phone_numbers) {
      [['1', '2', '3', '4', '5', '6', '13039873345'],
       ['1', '2', '3', '4', '5', '6', '444-555-9877'],
       ['1', '2', '3', '4', '5', '6', '(303) 887 3456']]
    }
    it 'removes whitespace' do
      expect(clean_contents(parsed_file)[0][3]).to eq("best")
    end
  end

  describe 'remove_non_integers' do
    it 'removes non integers from phone numbers' do
      expect(remove_non_integers('13039873345')).to eq("13039873345")
      expect(remove_non_integers('444-555-9877')).to eq("4445559877")
      expect(remove_non_integers('(303) 887 3456')).to eq("3038873456")
    end
  end

  describe 'add_country_code' do
    it 'adds country code' do
      expect(add_country_code('13039873345')).to eq("13039873345")
      expect(add_country_code('4445559877')).to eq("14445559877")
      expect(add_country_code('3038873456')).to eq("13038873456")
    end
  end

  describe 'transform_dates' do
    it 'uses the right format' do
      expect(transform_dates('9/30/19')).to eq("2019-09-30")
      expect(transform_dates('11/11/17')).to eq("2017-11-11")
      expect(transform_dates('9-30-19')).to eq("2019-09-30")
    end
  end
end