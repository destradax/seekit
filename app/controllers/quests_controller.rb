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
		render json: {quests: user.quests.as_json(include: :images)}
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
		if quest.get_distance_to_point(ulat.to_d, ulon.to_d) > 0.03
			render json: {error: "You are not there yet"} and return
		end

		cq = CompletedQuest.new
		cq.user = user
		cq.quest = quest
		if cq.save
			user.exp += quest.difficulty * 10
			user.save
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
		render json: {quests: Quest.all.as_json(include: :images)}
	end

	# Gets quests in range from the user
	# [Input]
	# 	* user_id: integer - the id of the current user
	# 	* latitude: decimal - the latitude of the position of the user
	# 	* longitude: decimal - the longitude of the position of the user
	# 	* range: integer - the range in Km that the user wants to search
	# [Output]
	# 	* quests: Array of Quest - all the quests within range and that haven't been completed
	# 	* Each quest includes images: Array of Image - all the images of the quest
	def search
		user = User.find_by_id(params[:user_id])
		unless user
			render json: {error: "user not found"} and return
		end

		quests = []
		ulat = params[:latitude] || 0
		ulat = ulat.to_d
		ulon = params[:longitude] || 0
		ulon = ulon.to_d
		range = params[:range] || 0
		range = range.to_i

		Quest.all.each do |quest|
			unless quest.users.include?(user)
				if quest.get_distance_to_point(ulat, ulon) < range
					quests.push(quest)
				end
			end
		end
		render json: {quests: quests.as_json(include: :images)}
	end

	# Adds a new quest
	# [Input]
	# 	* latitude: decimal - the latitude coordinate of the quest
	# 	* longitude: decimal - the longitude coordinate of the quest
	# 	* name: string - the name of the place this quest points to
	# 	* address: string - the address of the place this quest points to
	# 	* hint: string - a hint to help users find this place
	# 	* brief: text - a brief text about the place this quest points to, that will be shown once the user completes the quest
	# 	* difficulty: integer - the difficulty of this quest
	# 	* place_name: string - the name of the place the quest points to
	# 	* phone: string - the pone number of the place the quest points to
	# 	* fun_facts: text - fun facts about the place the quest points to
	# [Output]
	#		* quest: Quest - the new quest
	def add
		quest = Quest.new
		quest.name = params[:name]
		quest.address = params[:address]
		quest.hint = params[:hint]
		quest.brief = params[:brief]
		quest.latitude = params[:latitude] || 0
		quest.latitude = quest.latitude.to_d
		quest.longitude = params[:longitude] || 0
		quest.longitude = quest.longitude.to_d
		quest.difficulty = params[:difficulty] || 0
		quest.difficulty = quest.difficulty.to_i	
		quest.place_name = params[:place_name]
		quest.phone = params[:phone]
		quest.fun_facts = params[:fun_facts]
		
		if quest.save
			render json: quest, root: true
		else
			render json: {error: "could not add quest"}
		end
	end

	def index
		@quests = Quest.all
	end

	def show
		@quest = Quest.find(params[:id])
		3.times {@quest.images.build}
	end

	def update
		@quest = Quest.find(params[:id])
		if @quest.update_attributes(quest_params)
			redirect_to @quest, notice: "Quest updated"
		else
			redirect_to @quest, flash: {error: "Could not update quest"}
		end
	end

	def destroy
		@quest = Quest.find(params[:id])
		@quest.destroy
		redirect_to quests_path
	end

	def quest_params
		params.require(:quest)
			.permit(:latitude, :longitude, :name, :address, :hint, :brief, 
				:difficulty, :place_name, :phone, :fun_facts, 
				images_attributes: [:id, :url, :_destroy])
	end

	def new
		@quest = Quest.new
	end

	def create
		@quest = Quest.new(quest_params)
		if @quest.save
			redirect_to @quest, notice: "Quest created"
		else
			redirect_to @quest, flash: {error: "Could not create quest"}
		end
	end
end
