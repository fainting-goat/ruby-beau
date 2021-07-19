require 'rails_helper'

RSpec.describe ReportGenerator do
  describe 'create_output' do
    let(:filename) { 'spec/fixtures/test_file.txt' }
    let(:created_file) { 'spec/fixtures/output.csv' }
    let(:expected_results) {
      "Miranova,Cat,1988-01-08,35325,1988-01-08,1988-01-08,\n"
    }
    let(:error_stub) { double() }

    before do
      error_stub.stub(:report_error).with(anything(), anything(), anything())
      error_stub.stub(:report_warning).with(anything(), anything(), anything())
    end

    it 'returns the file contents' do
      create_output(filename, created_file, error_stub)
      expect(File.read(created_file)).to eq(expected_results)
    end
  end

  #TODO: move to a test for the report_errors class
  # describe 'create_report' do
  #   let(:created_file) { 'spec/fixtures/report.txt' }
  #   let(:expected_results) {
  #     "Everything processed fine because there's no error handling yet!\n"
  #   }
  #   it 'returns the file contents' do
  #     create_report(created_file)
  #     expect(File.read(created_file)).to eq(expected_results)
  #   end
  # end
end