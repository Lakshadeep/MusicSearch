require 'rubygems'
require 'sinatra'
require 'sinatra/base'
require 'sinatra/twitter-bootstrap'
require 'haml'
require "net/https"
require "uri"
require 'json'
require 'open-uri'
require 'httparty'
require 'rest-client'

require 'nokogiri'

register Sinatra::Twitter::Bootstrap::Assets
use Rack::CommonLogger
enable :inline_templates

set :public_folder, 'views'

get '/' do
	erb:index

end
post '/search/' do
	search_key = params[:search_key] || "Coldplay"
    erb :index_post, :locals => {'search_key' => search_key}
end

get '/artist' do
	erb:artist
end

get '/album' do
	erb:album
end

get '/track' do
	erb:track
end

# end



