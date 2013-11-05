class User < ActiveRecord::Base
	validates_presence_of :name, :email, :password,:message => "can't be blank!"
	validates_uniqueness_of :email, :message => "must be unique"
	
end
