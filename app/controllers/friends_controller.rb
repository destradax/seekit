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
		if request.post?
			friends = Friendship.where(user_id: params[:user_id])
			render json: friends
		end
	end

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
end
