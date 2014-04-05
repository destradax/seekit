module QuestsHelper

	def quest_pics(quest)
		pics = ""

		if @quest.images.any?
			@quest.images.each do |image|
				if image.url
					pics += image_tag image.url, class: "img-thumbnail"
				end
			end
		else
			pics += image_tag "default_pic.png", class: "img-thumbnail"
		end

		pics.html_safe
	end
end
