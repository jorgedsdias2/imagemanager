class Upload < ActiveRecord::Base
	belongs_to :page
	has_attached_file :image,
	# {
	# 	:storage => :ftp,
	# 	:path => "/{path}/web/teste/images/:style/:id/:filename",
	# 	:url => "/images/:style/:id/:filename",
	# 	:ftp_servers => [
	# 		{
	# 			:host => "{host}",
	# 			:user => "{usser}",
	# 			:password => "{password}",
	# 			:port => 21,
	# 			:passive => true
	# 		}
	# 	],
	# 	:ftp_connect_timeout => 5,
	# 	:ftp_ignore_failing_connections => true,
	# 	:ftp_keep_empty_directories => true,
	# 	styles: { thumb: "103x91>", medium: "300x160>" }
	# }
	styles: { thumb: "103x91>", medium: "300x160>" },
	:path => ":rails_root/public/images/:style/:id/:filename",
	:url  => "/images/:style/:id/:filename"
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
	validates :page_id, presence: true
end