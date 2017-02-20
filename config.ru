require './config/environment'

configure do
  raise 'You must specify a valid filename' unless ENV['FILENAME']
  FileFetcher.preload(ENV['FILENAME'])
end

run Rack::URLMap.new('/' => LineServer,
                     '/lines:line' => LineServer)