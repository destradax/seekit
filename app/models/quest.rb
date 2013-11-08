# [Attributes]
# 	* latitude: decimal - the latitude coordinate of the quest
# 	* longitude: decimal - the longitude coordinate of the quest
# 	* name: string - the name of the place this quest points to
# 	* address: string - the address of the place this quest points to
# 	* hint: string - a hint to help users find this place
# 	* brief: text - a brief text about the place this quest points to, that will be shown once the user completes the quest
# 	* difficulty: integer - the difficulty of this quest
class Quest < ActiveRecord::Base
end
