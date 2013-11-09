class FriendsController < ApplicationController
	# Adds a new friend
	# [Input]
	# 	* user_id: integer - the id of the current user 
	# 	* friend_id: integer - the id of the friend that the user wants to add
	# [Output]
	# 	* msg: string - in case that the friendship is succesfully created
	# 	* error: string - in case that the friendship can't be createt be created
	def add
		if request.post?
			if Friendship.exists?(user_id: params[:user_id], friend_id: params[:friend_id])
				render json: {error: "Already a friend"} and return
			end
			friendship = Friendship.new
			user = User.find_by_id(params[:user_id])
			friend = User.find_by_id(params[:friend_id])
			if user and friend
				friendship.user = user
				friendship.friend = friend
				if friendship.save
					render json: {msg: "Friend added"}
				else
					render json: {error: "Could not add friend"}
				end
			else
				render json: {error: "Could not find user or friend"}
			end
		end
	end

	# Gets the friends of a given user
	# [Input]
	# 	* user_id: integer - the id of the current user
	# [Output]
	# 	* friends: Array of User - the friends of the user
	def get
		if request.post?
			user = User.find_by_id(params[:user_id])
			unless user
				render json: {error: "user not fonud"} and return
			end
			
			render json: {friends: user.friends.each {|f| f.password = nil}}
		end
	end

	# Deletes a friend
	# [Input]
	# 	* user_id: integer - the id of the current user
	# 	* friend_id: integer - the id of the friend the user wants to delete
	# [Output]
	# 	* msg: string - in case the friend was deleted
	# 	* error: string - in case the friend can't be deleted
	def remove
		if request.post?
			friendship = Friendship.where(user_id: params[:user_id], friend_id: params[:friend_id]).first
			unless friendship
				render json: {error: "You are not friends"} and return
			end
			friendship.destroy
			render json: {msg: "Friend deleted"}
		end
	end

	# Gets the latest actions of the user's friends
	# [Input]
	# 	* user_id: integer - the id of the current user
	# [Output]
	# 	* feeds: Array - the feeds
	# 	Each feed contains the following information:
	# 	*	quest: Quest - the quest that was completed
	# 	* friend: User - the friend that completed the quest
	# 	* time: timestamp - the timestamp of when the friend completed the quest
	def feeds
		user = User.find_by_id(params[:user_id])
		unless user
			render json: {error: "user not fonud"} and return
		end
		cq = CompletedQuest.where(user_id: user.friends.ids).order(created_at: :desc).limit(10)
		feeds = []
		cq.each do |q|
			hash = {}
			hash[:quest] = q.quest
			friend = q.user
			friend.password = nil
			hash[:friend] = friend
			hash[:time] = q.created_at
			feeds.push(hash)
		end
		render json: {feeds: feeds}
	end
end
