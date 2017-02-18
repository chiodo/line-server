require 'thread'
class FileFetcher
  def initialize
    #prefetch and load into memory the entire file.
    @semaphore = Mutex.new
    @file_array = []
    @file = File.open( ENV['FILENAME'])
    #run through every line in the file, mark the byte offset of each line in an array.
    loop do
      break if not line = @file.gets
      @file_array[@file.lineno] = @file.pos
    end
  end

  def get_line(number)
    raise RequestedIndexError.new if number >= @file_array.length
    seek_pos = @file_array[number]
    #synchronized access is a bit faster than reopening the file every time.  Need this mutex because Puma is using
    #multiple threads for access
    @semaphore.synchronize do
      #set current file position to the offset for this line, then read the line.
      #ruby only keeps a bit of the file in memory here, so this is super efficient, memory wise.
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