module Myftp
	extend ActiveSupport::Concern

	$use_ftp = false

	included do
	end

	module ClassMethods
		def use_ftp?
			return $use_ftp
		end

		def ftp_params(name)
			ftp_server = {
				:host => "host",
				:user => "usser",
				:password => "password",
				:port => 21,
				:passive => true
			}
			return ftp_server[name]
		end
	end
end