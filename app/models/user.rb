class User < ActiveRecord::Base
	validates_presence_of :name, :email, :password,:message => "can't be blank!"
	validates_uniqueness_of :email, :message => "must be unique"
	has_many :friendships
	has_many :friends, through: :friendships
	
end
