require 'rails_helper'

RSpec.describe ReportGenerator do
  describe 'create_output' do
    let(:filename) { 'spec/fixtures/test_file.txt' }
    let(:created_file) { 'spec/fixtures/output.csv' }
    let(:expected_results) {
      "Beau,is,the,best,best,best,\nhe,is,just,super,super,super,\n"
    }

    it 'returns the file contents' do
      create_output(filename, created_file)
      expect(File.read(created_file)).to eq(expected_results)
    end
  end

  describe 'create_report' do
    let(:created_file) { 'spec/fixtures/report.txt' }
    let(:expected_results) {
      "Everything processed fine because there's no error handling yet!\n"
    }
    it 'returns the file contents' do
      create_report(created_file)
      expect(File.read(created_file)).to eq(expected_results)
    end
  end
end