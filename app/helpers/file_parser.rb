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

  def clean_contents(contents)
    # drop the first line since it's a column header
    contents.delete_at(0)

    #first go through line by line to get rid of whitespace
    contents.each do |line|
      for i in 0..6 do
        trim_whitespace!(line[i])
      end

      [DOB, EFFECTIVE_DATE, EXPIRY_DATE].each do |position|
        line[position] = transform_dates(line[position])
      end

      line[PHONE_NUMBER] = remove_non_integers(line[PHONE_NUMBER])
      line[PHONE_NUMBER] = add_country_code(line[PHONE_NUMBER])
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

  def add_country_code(item)
    # TODO check if the first number is a 1 and error if not
    # TODO check if the proper length and error if not
    item.length == 10 ? '1' + item : item
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

  def get_file_contents(filename)
    text = []
    File.readlines(filename).each do |line|
      text << line.split(',')
    end
    text
  end
end