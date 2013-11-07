class UserController < ApplicationController
  def login
		if request.post?
			user = User.find_by_email(params[:email])
			if user and user.password == params[:password]
				render json: user, root: true
			else
				render json: {error: "email / password incorrect"}
			end
		end
  end

  def register
		if request.post?
			user = User.new
			user.name = params[:name]
			user.email = params[:email]
			user.password = params[:password]
			user.exp = 0
			if user.save
				render json: user, root: true
			else
				render json: {error: "could not register user"}
			end
		end
  end

  def registerfacebook
  end

	def add_friend
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

	def remove_friend
	end
end
