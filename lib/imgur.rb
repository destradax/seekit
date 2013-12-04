require 'net/http'
require 'uri'
require 'base64'
require 'json'

class Imgur
	attr_accessor :base64, :url, :link, :hash

	def initialize
		@url = "https://api.imgur.com/3/upload.json"
	end
	
	def upload
		params = {image: @base64}

		uri = URI.parse(@url)

		https = Net::HTTP.new(uri.host, uri.port)
		https.use_ssl = true

		request = Net::HTTP::Post.new(uri.path)
		request["Authorization"] = "Client-ID fd06bfda312d6b4"
		request.set_form_data(params)

		response = https.request(request)

		@hash = JSON.parse(response.body)
		@link = hash["data"]["link"]

		@hash["success"]
	end
end

