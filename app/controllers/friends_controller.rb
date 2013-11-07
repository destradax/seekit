class FriendsController < ApplicationController
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

	def get
	end

	def remove
	end
end
