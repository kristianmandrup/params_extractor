module Params
	class Decoder
		attr_reader :params

		def initialize params
			raise "No profile params" unless params.present?
			@params = params
		end


		# fx decoder.hash['a'] returns value of a
		def hash
			@hash ||= Hash[decoded.split('&').collect{|p| p.split("=")}]
		end

		# decode in reverse order!
		def decoded
			@decoded ||= encrypter.decrypt Base64.decode64(params)
		end

		protected

		def encrypter
			Encrypter.instance
		end		
	end

	class Encrypter
		include Singleton
		
		attr_writer :password

		def encrypt data
			cipher.enc data
		end

		def decrypt data
			cipher.dec data
		end

		protected

		def cipher
			Gibberish::AES.new(password)
		end		

		def password
			@password ||= 'xyZ1/!2kdi9o_#€'
		end
	end

	class Encoder
		attr_reader :params

		def initialize params
			raise "No profile params" unless params.present?
			@params = case arg
			when Hash
				create_from arg
			when String
				arg
			else
				raise "Must be a Hash or String, was #{arg}"
			end
		end

		# encode after encryption to ensure Base64 compatibility in link
		def encoded
			@encoded ||= Base64.encode64 encrypter.encrypt(params)
		end

		protected

		# {:a => b, :c = 2} -> a=b&c=2
		def create_from arg
			@params = arg.inject([]) do |res, hash| 
				res << [hash.first, hash.last].join('=')
				res
			end.join('&')
		end		

		def encrypter
			Encrypter.instance
		end
	end
end