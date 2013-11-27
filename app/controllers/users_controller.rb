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

	def index
		@users = User.all
	end
end
