require 'rubygems'
require 'bundler'

Bundler.require(:default)                   # load all the default gems
Bundler.require(Sinatra::Base.environment)  # load all the environment specific gems

#require in our app and model class.  I'd probably do this with a globber if this were a larger app.
require './model/file_fetcher.rb'
require './app/line_server'
