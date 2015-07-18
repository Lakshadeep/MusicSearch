require 'rest-client'
require 'uri'

class Track
	@@api_link = 'http://ws.audioscrobbler.com/2.0/?'
	@@api_key= '0ec22e6fe858f16002cec5f6bfe151ae'
	@@format = 'json'
	@@limit = 4
	@@track_info

	def initialize(track_name,artist_name)
		url = URI.encode(@@api_link+'method=track.getinfo&artist='+ artist_name + '&track='+ track_name+'&api_key='+@@api_key+'&format='+@@format)
		response = RestClient::Request.execute(:method => :get,:url => url,)
		# REVIEW -- why is this a class variable?
 	    @@track_info = JSON.parse(response)
		
	end

	def track_info()
		temp = {"name" => @@track_info["track"]["name"],
				"artist" => @@track_info["track"]["artist"]["name"],
				"album" => @@track_info["track"]["album"].nil? ? "" : @@track_info["track"]["album"]["title"],
				"summary" => @@track_info["track"]["wiki"].nil? ? "" : @@track_info["track"]["wiki"]["summary"] ,
				"image_link" => @@track_info["track"]["album"].nil? ? "" : @@track_info["track"]["album"]["image"][3]["#text"]}
		return temp
	end

	

end


