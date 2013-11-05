require 'login_request'
require 'login_response'
class UserController < ApplicationController
  def login
		lr = LoginRequest.new(JSON.parse params[:LoginRequest])
		user = User.find_by_email(lr.email)
		response = nil
		if user and user.password == lr.password
			response = LoginResponse.new(user)
		end
		render json: response
  end

  def register
  end

  def registerfacebook
  end
end
