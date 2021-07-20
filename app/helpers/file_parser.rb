module FileParser
  # we can identify where each data item is based on position
  # since the csv comes with a header we could potentially identify it by that instead of position
  # bit outside of the current scope though

  FIRST_NAME = 0
  LAST_NAME = 1
  DOB = 2
  MEMBER_ID = 3
  EFFECTIVE_DATE = 4
  EXPIRY_DATE = 5
  PHONE_NUMBER = 6

  REQUIRED_FIELDS = [FIRST_NAME, LAST_NAME, DOB, MEMBER_ID, EFFECTIVE_DATE]

  # I'm not a huge fan of having the errors object passed in here like this
  # this method is also pretty beefy
  # let's live with this situation until tests are written so refactoring will be safer
  # even if tests are moved to a new file, at least they'll be known good tests first
  def clean_contents(contents, errors)
    # drop the first line since it's a column header
    contents.delete_at(0)

    valid_lines = []
    contents.each do |line|
      errored = validate_required_fields(line, errors)
      valid_lines << line unless errored
    end

    #first go through line by line to get rid of whitespace
    valid_lines.each do |line|
      for i in 0..6 do
        trim_whitespace!(line[i])
      end

      [DOB, EFFECTIVE_DATE, EXPIRY_DATE].each do |position|
        line[position] = transform_dates(line[position])
      end

      line[PHONE_NUMBER] = remove_non_integers(line[PHONE_NUMBER])
      line[PHONE_NUMBER] = add_country_code(line[PHONE_NUMBER], errors, line)
    end
  end

  def trim_whitespace!(item)
    item.strip!
  end

  def remove_non_integers(item)
    clean_item = ""
    item.each_char do |char|
      if (Integer(char) != nil rescue false)
        clean_item = "#{clean_item}#{char}"
      end
    end
    clean_item
  end

  # again, I dislike passing in errors AND the line, but save refactoring this out until tests exist
  def add_country_code(item, errors, line)
    case item.length
    when 10
      '1' + item
    when 11
      if item[0].eql?('1')
        item
      else
        errors.report_warning(line, PHONE_NUMBER, "invalid phone number")
        ''
      end
    else
      errors.report_warning(line, PHONE_NUMBER, "invalid phone number")
      ''
    end
  end

  def transform_dates(item)
    return if item.empty?

    # TODO handle other formats/unsupported formats/better default handling if this fails
    begin
      date = if item.include?('/')
               Date.strptime(item, '%m/%d/%y')
             elsif item.include?('-')
               Date.strptime(item, '%m-%d-%y')
             end
    rescue ArgumentError
      date = Date.parse(item) # hope Ruby can figure it out
    end

    date.iso8601
  end

  def validate_required_fields(line, errors)
    errored = false
    REQUIRED_FIELDS.each do |field|
      if line[field].empty?
        errors.report_error(line, field, "missing required field")
        errored = true
      end
    end
    errored
  end

  def get_file_contents(filename)
    text = []
    File.readlines(filename).each do |line|
      text << line.split(',')
    end
    text
  end
end