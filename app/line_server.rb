
class LineServer < Sinatra::Base
  get '/' do
    #left this in here as a way to benchmark the difference between requesting a line and an empty request
    'Hi!'
  end

  get '/lines/:line' do
    begin
      FileFetcher.get_line(params['line'].to_i)
    rescue RequestedIndexError
      halt(413)
    end
  end
end