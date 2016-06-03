class Upload < ActiveRecord::Base
	include Rails.application.routes.url_helpers

	def to_upload
		{
			"name" => read_attribute(:file_name),
			"size" => read_attribute(:file_size),
			"url" => "",
			"delete_url" => upload_path(self),
			"delete_type" => "DELETE"
		}
	end
end