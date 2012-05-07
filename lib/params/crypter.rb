require 'singleton'
require 'gibberish'

module Params
	class Crypter
		include Singleton

		class << self
			def on!
				@on = true
			end

			def off!
				@on = false
			end

			def on?
				!(@on == false)
			end

			def off?
				!on?
			end

			def password
				Params::Crypter.instance.password
			end
			
			def password= pass
				Params::Crypter.instance.password = pass
			end
		end

		attr_writer :password

		def on?
			Params::Crypter.on?
		end

		def off?
			Params::Crypter.off?
		end

		def encrypt data
			return data if off?
			cipher.enc data
		end

		def decrypt data
			return data if off?
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
