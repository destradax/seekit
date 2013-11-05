class UserController < ApplicationController
  def login
		if request.post?
			user = User.find_by_email(params[:email])
			if user and user.password == params[:password]
				render json: user, root: true
			else
				render json: nil, status: 400
			end
		end
  end

  def register
		if request.post?
			user = User.new
			user.name = params[:name]
			user.email = params[:email]
			user.password = params[:password]
			if user.save
				render json: user, root: true
			else
				render json: {error: "could not register user"}
			end
		end
  end

  def registerfacebook
  end
end
