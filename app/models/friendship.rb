# Holds the relationships between users and their friends
# [Attributes]
# 	* friend_id: integer - the id of the friend the user added
# 	* user_id: integer - the id of the user
class Friendship < ActiveRecord::Base
	attr_accessor :user_id, :friend_id
	
	belongs_to :user
	belongs_to :friend, class_name: "User"
end
