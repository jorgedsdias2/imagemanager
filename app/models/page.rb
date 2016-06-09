# -*- encoding : utf-8 -*-
class Page < ActiveRecord::Base
	belongs_to :user
	has_many :uploads
	validates :title, presence: true, uniqueness: true
	validates :status, presence: true
	validates :user_id, presence: true
end