module Myftp
	extend ActiveSupport::Concern

	$use_ftp = true

	included do
	end

	module ClassMethods
		def use_ftp?
			return $use_ftp
		end

		def ftp_params(name)
			ftp_params = {
				:absolute_path => "http://www.teste.cosengenharia.com.br/teste",
				:path => "/cosengenharia3/Web/teste/images/:style/:id/:filename",
				:url => "/images/:style/:id/:filename",
				:host => "ftp.teste.cosengenharia.com.br",
				:user => "cosengenharia3",
				:password => "coss1492016",
				:port => 21,
				:passive => true
			}
			return ftp_params[name]
		end
	end
end