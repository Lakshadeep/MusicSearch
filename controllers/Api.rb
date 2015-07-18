require 'rest-client'
require 'uri'

class Api
	@api_link = 'http://ws.audioscrobbler.com/2.0/?'
	@api_key= '0ec22e6fe858f16002cec5f6bfe151ae'
	@format = 'json'
	@limit = 4

	def self.search_artist(search_key)
		url = URI.encode(@api_link + 'method=artist.search&artist='+ search_key + '&api_key='+ @api_key + '&limit='+@limit.to_s+'&format='+@format)
		response = RestClient::Request.execute(:method => :get,:url => url,)
 	    artist_result = JSON.parse(response)
		total_results = artist_result["results"]["opensearch:totalResults"].to_i
		results = []

		if total_results != 0 
 	    	artist_result["results"]["artistmatches"]["artist"].each { |x|
 	    		temp = {"name" => x["name"],
 	    				"mbid" => x["mbid"],
 	    				"img_link" => x["image"][2]["#text"] 
 	    				}
 	    		results.push(temp)
 	    	}
 	    end
 	    return results
	end


	def self.search_album(search_key)
		url = URI.encode(@api_link + 'method=album.search&album='+ search_key + '&api_key='+ @api_key + '&limit='+@limit.to_s+'&format='+@format)
		response = RestClient::Request.execute(:method => :get,:url => url,)
 	    album_result = JSON.parse(response)
		total_results = album_result["results"]["opensearch:totalResults"].to_i
		results = []

		if total_results != 0 
 	    	album_result["results"]["albummatches"]["album"].each { |x|
 	    		temp = {"name" => x["name"],
 	    				"artist" => x["artist"],
 	    				"img_link" => x["image"][2]["#text"] 
 	    				}
 	    		results.push(temp)
 	    	}
 	    end
 	    return results
 	end

 	def self.search_track(search_key)
		url = URI.encode(@api_link + 'method=track.search&track='+ search_key + '&api_key='+ @api_key + '&limit='+@limit.to_s+'&format='+@format)
		response = RestClient::Request.execute(:method => :get,:url => url,)
 	    track_result = JSON.parse(response)
		total_results = track_result["results"]["opensearch:totalResults"].to_i
		results = []

		if total_results != 0 
 	    	track_result["results"]["trackmatches"]["track"].each { |x|
 	    		temp = {"name" => x["name"],
 	    				"artist" => x["artist"],
 	    				"img_link" => x["image"].nil? ? "" : x["image"][2]["#text"] 
 	    				}
 	    		results.push(temp)
 	    	}
 	    end
 	    return results
 	end




end