module ApplicationHelper
	def google_maps_api_url
		api_key = "AIzaSyCYXyVuRA57ak78Xc9mncpylfFA1J9gVYM"
		"https://maps.googleapis.com/maps/api/js?key=#{api_key}&sensor=false"
	end
end
