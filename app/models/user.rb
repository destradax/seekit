# [Attributes]
# 	* name:	string - the name of the user
# 	* email:	string - the email of the user
# 	* password: string - the password of the user
# 	* facebookId: string - the facebook id of the user
# 	* imageURL: string - the URL adddress of the user's image
# 	* exp: integer - the experience the user has gained
class User < ActiveRecord::Base
	validates_presence_of :name, :email, :password,:message => "can't be blank!"
	validates_uniqueness_of :email, :message => "must be unique"
	has_many :friendships
	has_many :friends, through: :friendships
	has_many :completed_quests
	has_many :quests, through: :completed_quests
	
end
