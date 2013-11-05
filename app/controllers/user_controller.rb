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
  end

  def registerfacebook
  end
end
