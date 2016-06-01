class User < ActiveRecord::Base
	has_secure_password
	validates :name, presence: true
	validates :email, presence: true, uniqueness: true
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

	after_initialize :set_user_role
	before_destroy :dont_delete_administrator

	private
		def set_user_role
			if self.role != 'administrator'
				self.role = 'user'
			end
		end

		def dont_delete_administrator
			if self.role == 'administrator'
				return false
			end
		end	
end