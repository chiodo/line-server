require './config/environment'

configure do
  if ENV['FILENAME'].empty?
    puts 'You must specify a filename. Halting startup'
    exit(1)
  end

  #Preload the file at startup time.
  FileFetcher.preload(ENV['FILENAME'])
end

run Rack::URLMap.new('/' => LineServer,
                     '/lines:line' => LineServer)