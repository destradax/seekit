class User < ActiveRecord::Base
	validates_presence_of :name, :email, :password,:message => "can't be blank!"
end
