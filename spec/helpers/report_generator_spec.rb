require 'rails_helper'

RSpec.describe ReportGenerator do
  let(:expected_results) {
    "Beau,is,the,best,best,best,\nhe,is,just,super,super,super,\n"
  }

  describe 'create_report' do
    let(:filename) { 'spec/fixtures/test_file.txt' }
    let(:created_file) { 'spec/fixtures/report.csv' }

    it 'returns the file contents' do
      create_report(filename, created_file)
      expect(File.read(created_file)).to eq(expected_results)
    end
  end
end