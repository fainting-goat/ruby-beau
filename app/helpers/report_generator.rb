module ReportGenerator
  include FileParser

  DEFAULT_FILE = 'input.csv'
  DEFAULT_OUTPUT = 'output.csv'
  DEFAULT_REPORT = 'report.txt'

  # TODO: this could probably use a better name
  def handle_input_file(input_file = DEFAULT_FILE, output_file = DEFAULT_OUTPUT, report_file = DEFAULT_REPORT)
    create_output(input_file, output_file)
    create_report(report_file)
  end

  # can accept a dynamic filename, but defaults to the one provided in the exercise
  def create_output(filename, report_filename)
    file_contents = get_file_contents(filename)
    cleaned_contents = clean_contents(file_contents)
    convert_to_csv(cleaned_contents, report_filename)
  end

  def create_report(filename)
    File.open(filename, 'w+') do |f|
      f.puts "Everything processed fine because there's no error handling yet!"
    end
  end

  private

  def convert_to_csv(contents, filename)
    File.open(filename, 'w+') do |f|
      contents.each do |line|
        f.puts line.join(',')
      end
    end
  end
end