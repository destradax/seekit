# Holds the relationships between users and their completed quests
# [Attributes]
# 	* user_id: integer - the id of the user
# 	* quest_id: integer -the id of the completed quest
class CompletedQuest < ActiveRecord::Base
	attr_accessor :user_id, :quest_id

	belongs_to :user
	belongs_to :quest
end
