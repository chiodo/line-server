require 'sinatra'
file_fetcher = FileFetcher.new

get '/' do
  #left this in here as a way to benchmark the difference between requesting a line and an empty request
  'Hi!'
end

get '/lines/:line' do
  begin
    file_fetcher.get_line(params['line'].to_i)
  rescue RequestedIndexError
    halt(413)
  end
end