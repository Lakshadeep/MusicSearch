require 'rubygems'
require 'bundler'
require 'sinatra'
require 'sinatra/twitter-bootstrap'
require 'sass'


Bundler.require

require './app'
run MusicSearch
