class Upload < ActiveRecord::Base
	include Myftp

	belongs_to :page

	if self.use_ftp?
		has_attached_file :image,
		{
			:storage => :ftp,
			:path => self.ftp_params(:path),
			:url => self.ftp_params(:url),
			:ftp_servers => [
				{
					:host => self.ftp_params(:host),
					:user => self.ftp_params(:user),
					:password => self.ftp_params(:password),
					:port => self.ftp_params(:port),
					:passive => self.ftp_params(:passive)
				}
			],
			:ftp_connect_timeout => 5,
			:ftp_ignore_failing_connections => true,
			:ftp_keep_empty_directories => true,
			styles: { thumb: "103x91>", medium: "300x160>" }
		}
	else
		has_attached_file :image,
		styles: { thumb: "103x91>", medium: "300x160>" },
		:path => ":rails_root/public/images/:style/:id/:filename",
		:url  => "/images/:style/:id/:filename"		
	end

	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
	validates :page_id, presence: true
end