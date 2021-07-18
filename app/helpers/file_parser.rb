module FileParser
  def clean_contents(contents)
    #first go through line by line
    contents.each do |line|
      # then go through the individual items
      # we can keep track of what item we're on positionally
      # though we might not actually need to, maybe refactor this
      for i in 0..6 do
        trim_whitespace!(line[i])
      end

      line[6] = remove_non_integers(line[6])
      line[6] = add_country_code(line[6])
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
    # TODO handle other formats/unsupported formats
    date = if item.include?('/')
             Date.strptime(item, '%m/%d/%y')
           elsif item.include?('-')
             Date.strptime(item, '%m-%d-%y')
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