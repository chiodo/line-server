require 'thread'
class FileFetcher

  def self.preload(filename)
    @@FILE_ARRAY = []
    @@FILE = File.open(filename)
    @@SEMAPHORE = Mutex.new
    #run through every line in the file, mark the byte offset of each line in an array.
    loop do
      break if not line = @@FILE.gets
      @@FILE_ARRAY[@@FILE.lineno] = @@FILE.pos
    end
  end

  def self.get_line(number)
    raise RequestedIndexError.new if number >= @@FILE_ARRAY.length
    seek_pos = @@FILE_ARRAY[number]
    #synchronized access is a bit faster than reopening the file every time.  Need this mutex because Puma is using
    #multiple threads for access
    @@SEMAPHORE.synchronize do
      #set current file position to the offset for this line, then read the line.
      #ruby only keeps a bit of the file in memory here, so this is super efficient, memory wise.
      @@FILE.pos = seek_pos
      @@FILE.readline
    end
  end
end

#I created this custom error class as a means to abstract away the
# way we determine if the requested line number was too big.  This lets the app class not need
#the internals exposed.
class RequestedIndexError < StandardError
  def initialize(msg='Request exceeds size of file')
    super
  end
end
