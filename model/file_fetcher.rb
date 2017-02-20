class FileFetcher

  def self.preload(filename)
    #prefetch and load into memory the entire file.
    @@FILE_ARRAY = File.new(filename).readlines
  end

  def self.get_line(number)
    raise RequestedIndexError.new if number >= @@FILE_ARRAY.length
    @@FILE_ARRAY[number]
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