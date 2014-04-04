module UsersHelper
 
 def user_profile_pic(user)
  if @user.imageURL=="" || @user.imageURL.nil?
   image_tag "default_pic.png", class: "img-thumbnail"
  else
   image_tag @user.imageURL, class: "img-thumbnail"
  end
 end
 
end
