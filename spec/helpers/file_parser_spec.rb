require 'rails_helper'

RSpec.describe FileParser do
  let(:parsed_file) {
    [["Beau", " Dog", " 1/8/88", "  1234 ", " 1/8/88", " 1/8/88", "  123456789\n"],
     ["Miranova", " Cat", " 1/8/88", "  35325 ", " 1/8/88", "  1/8/88", " 123456789"]]
  }
  let(:error_stub) { double() }

  before do
    error_stub.stub(:report_error).with(anything(), anything(), anything())
    error_stub.stub(:report_warning).with(anything(), anything(), anything())
  end

  describe 'get_file_contents' do
    let(:filename) { 'spec/fixtures/test_file.txt' }
    let(:content) {}

    it 'returns the file contents as a nested array' do
      expect(get_file_contents(filename)).to eq(parsed_file)
    end
  end

  describe 'clean_contents' do
    it 'removes whitespace' do
      expect(clean_contents(parsed_file, error_stub)[0][3]).to eq("35325")
    end

    it 'drops lines that fail validation' do
      fail
    end

    it 'transforms the date fields' do
      fail
    end

    it 'correctly sanitizes phone numbers' do
      fail
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
      expect(add_country_code('13039873345', error_stub, 'junk')).to eq("13039873345")
      expect(add_country_code('4445559877', error_stub, 'junk')).to eq("14445559877")
      expect(add_country_code('3038873456', error_stub, 'junk')).to eq("13038873456")
    end

    it 'reports an error if the country code is incorrect' do
      fail
    end
  end

  describe 'transform_dates' do
    it 'uses the right format' do
      expect(transform_dates('9/30/19')).to eq("2019-09-30")
      expect(transform_dates('11/11/17')).to eq("2017-11-11")
      expect(transform_dates('9-30-19')).to eq("2019-09-30")
    end

    it 'defaults to Date.parse if the other parsing fails' do
      fail
    end
  end

  describe 'validate_required_fields' do
    it 'returns false if a required field is missing' do
      fail
    end
  end

  # this would normally be an integration test, probably in its own file, but I want to move on to further validations
  # so right now it's just dumping the results so I can look at them
  describe 'clean_contents does all the things' do
    it 'does everything' do
      puts clean_contents(get_file_contents('input.csv'), error_stub)
    end
  end
end