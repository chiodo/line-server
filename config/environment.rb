require 'rubygems'
require 'bundler'

Bundler.require(:default)                   # load all the default gems
Bundler.require(Sinatra::Base.environment)  # load all the environment specific gems

require './model/file_fetcher.rb'
require './app/line_server'
