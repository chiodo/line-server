class FileFetcher
  def initialize
    #prefetch and load into memory the entire file.
    @file_array = File.new(ENV['FILENAME']).readlines
  end

  def get_line(number)
    raise RequestedIndexError.new if number >= @file_array.length
    @file_array[number]
  end
end

#I created this custom error class as a means to abstract away the
# way we determine if the requested line number was too big.
class RequestedIndexError < StandardError
  def initialize(msg='Request exceeds size of file')
    super
  end
end