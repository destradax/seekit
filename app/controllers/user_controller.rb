require 'imgur'
class UserController < ApplicationController

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

	# Not implemented yet
  def registerfacebook
  end

end
