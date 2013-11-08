# [Attributes]
# 	* quest_id: integer - the id of the quest this image belongs to
# 	* url: string - the url of this image
class Image < ActiveRecord::Base
  belongs_to :quest
end
