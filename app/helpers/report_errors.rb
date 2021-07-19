class ReportErrors
  def initialize
    @errors = []
  end

  def report_error(line, position, error)
    @errors << "There is a #{error} error at position: #{position}"
    @errors << line.join(' , ')
  end

  def write_report(filename)
    File.open(filename, 'w+') do |f|
      @errors.each do |line|
        f.puts line
      end
    end
  end
end