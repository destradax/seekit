class Friendship < ActiveRecord::Base
	attr_accessor :user_id, :friend_id
	
	belongs_to :user
	belongs_to :friend, class_name: "User"
end
