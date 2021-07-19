module ReportGenerator
  include FileParser
  DEFAULT_FILE = 'input.csv'
  DEFAULT_REPORT = 'output.csv'

  # can accept a dynamic filename, but defaults to the one provided in the exercise
  def create_report(filename = DEFAULT_FILE, report_filename = DEFAULT_REPORT)
    file_contents = get_file_contents(filename)
    cleaned_contents = clean_contents(file_contents)
    convert_to_csv(cleaned_contents, report_filename)
  end

  def convert_to_csv(contents, filename)
    File.open(filename, 'w+') do |f|
      contents.each do |line|
        f.puts line.join(',')
      end
    end
  end
end