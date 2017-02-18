require 'thread'


class FileFetcher
  def initialize
    #prefetch and load into memory the entire file.
    @semaphore = Mutex.new
    @file_array = []
    @file = File.open( ENV['FILENAME'])

    loop do
      break if not line = @file.gets
      @file_array[@file.lineno] = @file.pos
    end
  end

  def get_line(number)
    raise RequestedIndexError.new if number >= @file_array.length
    seek_pos = @file_array[number]
    @semaphore.synchronize do
      @file.pos = seek_pos
      @file.readline
    end

  end
end

#I created this custom error class as a means to abstract away the
# way we determine if the requested line number was too big.
class RequestedIndexError < StandardError
  def initialize(msg='Request exceeds size of file')
    super
  end
end