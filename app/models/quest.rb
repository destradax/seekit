# [Attributes]
# 	* latitude: decimal - the latitude coordinate of the quest
# 	* longitude: decimal - the longitude coordinate of the quest
# 	* name: string - the name of the place this quest points to
# 	* address: string - the address of the place this quest points to
# 	* hint: string - a hint to help users find this place
# 	* brief: text - a brief text about the place this quest points to, that will be shown once the user completes the quest
# 	* difficulty: integer - the difficulty of this quest
class Quest < ActiveRecord::Base
	has_many :images
	has_many :completed_quests
	has_many :users, through: :completed_quests

	# Returns the distance in Km to a given point 
	# [Input]
	# 	* ulat: decimal - the latitude coordinate of the point
	# 	* ulon: decimal - the longitude coordinate of the point
	def get_distance_to_point(ulat, ulon)
		# RAD_PER_DEG = Math::PI / 180
		rad_per_deg = 0.017453292519943295
		earth_radius = 6371 # in Km

		qlat = self.latitude
		qlon = self.longitude

		dlat = ulat - qlat
		dlon = ulon - qlon

		dlon_rad = dlon * rad_per_deg 
		dlat_rad = dlat * rad_per_deg

		ulat_rad = ulat * rad_per_deg
		ulon_rad = ulon * rad_per_deg

		qlat_rad = qlat * rad_per_deg
		qlon_rad = qlon * rad_per_deg


		a = (Math.sin(dlat_rad/2))**2 + Math.cos(ulat_rad) * Math.cos(qlat_rad) * (Math.sin(dlon_rad/2))**2
		c = 2 * Math.atan2( Math.sqrt(a), Math.sqrt(1-a))

		dKm = earth_radius * c # delta in kilometers
	end
end
