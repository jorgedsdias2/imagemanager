class Upload < ActiveRecord::Base
	has_attached_file :image,
	styles: { thumb: "103x91>", medium: "300x160>" },
	:path => ":rails_root/public/images/:style/:id/:filename",
	:url  => "/images/:style/:id/:filename"
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end