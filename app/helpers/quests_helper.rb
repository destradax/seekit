module QuestsHelper

	def quest_pics(quest)
		pics = ""

		if @quest.images.any?
			@quest.images.each do |image|
				if image.url
					pics += "<a href='" + image.url + "' data-lightbox='quest-pics'>"
					pics += image_tag image.url, class: "img-thumbnail"
					pics += "</a>"
				end
			end
		else
			pics += image_tag "default_pic.png", class: "img-thumbnail"
		end

		pics.html_safe
	end
end
