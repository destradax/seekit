class QuestsController < ApplicationController
	# Gets the quests completed by the user
	# [Input]
	# 	* user_id: integer - the id of the current user
	# [Output]
	# 	* quests: Array of Quest - the quests completed by the user
	# 	* Each quest includes images: Array of Image - all the images of the quest
	# 	* error: string - in case the user is not found
	def get_completed
		user = User.find_by_id(params[:user_id])
		unless user
			render json: {error: "user not found"} and return
		end
		render json: user.quests.to_json(include: :images)
	end

	# Tries to complete a quest
	# [Input]
	# 	* user_id: integer - the id of the current user
	# 	* quest_id: integer - the id of the quest the user is trying to compelte
	# 	* latitude: decimal - the latitude of the position of the user
	# 	* longitude: decimal - the longitude of the position of the user
	# [Output]
	# 	* msg: string - in case the quest is marked as completed
	# 	* error: string - in case the quest can't be marked as completed
	def seekit
		user = User.find_by_id(params[:user_id])
		unless user
			render json: {error: "user not found"} and return
		end
		quest = Quest.find_by_id(params[:quest_id])
		unless quest
			render json: {error: "quest not found"} and return
		end
		if CompletedQuest.exists?(user_id: user.id, quest_id: quest.id)
			render json: {error: "user already completed this quest"} and return
		end
		
		ulat = params[:latitude] || 0
		ulon = params[:longitude] || 0
		distance = quest.get_distance_to_point(ulat.to_d, ulon.to_d)
		puts "DISTANCE: ", distance
		if quest.get_distance_to_point(ulat.to_d, ulon.to_d) > 0.03
			render json: {error: "You are not there yet"} and return
		end

		cq = CompletedQuest.new
		cq.user = user
		cq.quest = quest
		if cq.save
			render json: {msg: "quest completed"} and return 
		else
			render json: {error: "could not complete quest"} and return
		end
	end

	# Gets all the quests
	# [Output]
	# 	* quests: Array of Quest - all the quests
	# 	* Each quest includes images: Array of Image - all the images of the quest
	def get_all
		# TODO return the array inside of an object
		render json: Quest.all.to_json(include: :images)
	end
end
