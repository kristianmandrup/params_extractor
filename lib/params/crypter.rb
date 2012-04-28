require 'singleton'
require 'gibberish'

module Params
	class Crypter
		include Singleton

		def self.password
			Params::Crypter.instance.password
		end
		
		def self.password= pass
			Params::Crypter.instance.password = pass
		end

		attr_writer :password

		def encrypt data
			cipher.enc data
		end

		def decrypt data
			cipher.dec data
		end

		protected

		def cipher
			@cipher ||= Gibberish::AES.new(password)
		end		

		def password
			@password ||= 'xyZ1/!2kdi9o_#'
		end
	end
end
