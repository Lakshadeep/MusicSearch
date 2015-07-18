require 'rest-client'
require 'uri'


class Artist
	@@api_link = 'http://ws.audioscrobbler.com/2.0/?'
	@@api_key= '0ec22e6fe858f16002cec5f6bfe151ae'
	@@format = 'json'
	@@limit = 4
	@@artist_info

	def initialize(mbid)
		url = URI.encode(@@api_link+'method=artist.getinfo&mbid='+ mbid +'&api_key='+@@api_key+'&format='+@@format)
		response = RestClient::Request.execute(:method => :get,:url => url,)
		# REVIEW -- why is this a class variable?
 	    @@artist_info = JSON.parse(response)		
	end

	def artist_info()
		temp = {"name" => @@artist_info["artist"]["name"],
				"summary" => @@artist_info["artist"]["bio"]["summary"],
				"image_link" => @@artist_info["artist"]["image"][4]["#text"]}
		return temp
	end



end


