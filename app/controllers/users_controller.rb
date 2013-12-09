require 'imgur'
class UsersController < ApplicationController

	# Logs the user in
	# [Input]
	# 	* email: string - the email address of the user trying to log in
	# 	* password: string - the password of the user trying to log in
	# [Output]
	# 	* user: User - the user that has successfully logged in
	# 	* error: string - in case the user can't log in
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

	# Registers a new user
	# [Input]
	# 	* name: string - the name of the new user
	# 	* email: string - the email address of the new user
	# 	* password: string - the password of the new user
	# 	* imagedata: string - the image encoded in base 64. Optional
	#
	# [Output]
	# 	* user: User - the new user
	# 	* error: string - in case the user can't register
  def register
		if request.post?
			user = User.new
			user.name = params[:name]
			user.email = params[:email]
			user.password = params[:password]
			user.exp = 0

			if params[:imagedata]
				image = Imgur.new
				image.base64 = params[:imagedata]
				if image.upload
					user.imageURL = image.link
				end
			end

			if user.save
				render json: user, root: true
			else
				render json: {error: "could not register user"}
			end
		end
  end

	# Logs a user in with a facebookId. If the user does not exist, 
	# a new one is created. If the user exists, the facebookId is
	# updated
	# [Input]
	# 	* name: string - the name of the new user trying to log in
	# 	* email: string - the email address of the new user trying to log in
	# 	* facebookId: string - the facebookId of the new user trying to log in
	#
	# [Output]
	# 	* user: User - the user that has successfully logged in
	# 	* error: string - in case the user can't log in
  def facebook_login
		if request.post?
			user = User.find_by_email(params[:email])
			if user
				user.facebookId = params[:facebookId]
			else
				user = User.new
				user.name = params[:name]
				user.email = params[:email]
				user.facebookId = params[:facebookId]
				user.exp = 0
			end

			if user.save
				render json: user, root: true
			else
				render json: {error: "could not update user"}
			end
		end
  end

	# Searches for users given their email address
	# [Input]
	# 	* emails: Array of string - the email addresses to search for
	# [Output]
	# 	* users: Array of User - the users found
	def search_emails
		if request.post?
			if params[:emails].class == Array
				emails = params[:emails]
			else
				emails = JSON.parse(params[:emails])
			end
			users = []
			emails.each do |email|
				user = User.find_by_email(email)
				if user
					user.password = nil
					users.push(user) 
				end
			end

			render json: {users: users.as_json}
		end
	end

	# Uploads an image and returns the link to it
	# [Input]
	# 	* user_id: integer - the id of the current user
	# 	* imagedata: string - the image encoded in base 64
	# [Output]
	# 	* user: User - the User with the imageURL property updated
	# 	* error: string - in case the image couldn't be uploaded
	def change_pic
		if request.post?
			image = Imgur.new
			image.base64 = params[:imagedata]
			if image.upload
				user = User.find(params[:user_id])
				user.imageURL = image.link
				if user.save
					render json: user, root: true and return
				else
					render json: {error: "Could not update the user"} and return
				end
			else
				render json: {error: "Could not upload image"} and return
			end
		end
	end

	# Searches for friends given their email address
	# [Input]
	# 	* user_id: integer - the id of the current user
	# 	* emails: Array of string - the email addresses to search for
	# [Output]
	# 	* friends: Array of User - the users found that are friends with the current user
	# 	* nonfriends: Array of User - the users found that are not friends with the current user
	def seach_friends_by_email
		if request.post?
			if params[:emails].class == Array
				emails = params[:emails]
			else
				emails = JSON.parse(params[:emails])
			end

			user = User.find(params[:user_id])
			unless user
				render {error: "Couldn't find user with id #{user_id}"}
			end

			friends = []
			nonfriends = []]
			emails.each do |email|
				friend = User.find_by_email(email)
				if friend
					friend.password = nil
					if user.friends.include? friend
						friends.push friend
					else
						nonfriends.push friend
					end
				end
			end

			render json: {friends: friends, nonfriends: nonfriends}
		end
	end

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			redirect_to @user, notice: "User updated"
		else
			redirect_to @user, flash: {error: "Could not update user"}
		end
	end

	def user_params
		params.require(:user).permit(:name, :email, :facebookId, :imageURL, :exp)
	end
end
