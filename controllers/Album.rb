require 'rest-client'
require 'uri'

class Album
	@@api_link = 'http://ws.audioscrobbler.com/2.0/?'
	@@api_key= '0ec22e6fe858f16002cec5f6bfe151ae'
	@@format = 'json'
	@@limit = 4
	@@album_info

	def initialize(album_name,artist_name)
		url = URI.encode(@@api_link+'method=album.getinfo&artist='+ artist_name + '&album='+ album_name+'&api_key='+@@api_key+'&format='+@@format)
		response = RestClient::Request.execute(:method => :get,:url => url,)
 	    @@album_info = JSON.parse(response)
		
	end

	def album_info()
		temp = {"name" => @@album_info["album"]["name"],
				"artist" => @@album_info["album"]["artist"],
				"summary" => @@album_info["album"]["wiki"].nil? ? "": @@album_info["album"]["wiki"]["summary"] ,
				"image_link" => @@album_info["album"]["image"][3]["#text"]}
		return temp
	end

	def track_list()
		tracks_info = []
		if !@@album_info["album"]["tracks"]["track"].nil? 
	   	    @@album_info["album"]["tracks"]["track"].each{ |x| 
				temp = {"name" => x["name"],
		      			"duration" => x["duration"].to_i }
		      	tracks_info.push(temp)
		    }
		end 
		return tracks_info
	end

end


