# -*- encoding : utf-8 -*-
class Page < ActiveRecord::Base
	belongs_to :user
	has_many :uploads
	validates :title, presence: true, uniqueness: true
	validates :status, presence: true
	validates :user_id, presence: true

	before_destroy :dont_delete_page_with_image

	private
		def dont_delete_page_with_image
			if self.uploads.any?
				return false
			end
		end
end