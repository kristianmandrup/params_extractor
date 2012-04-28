module Params
	class Encoder
		attr_reader :params

		def initialize params
			raise "No profile params" if !params || params.empty?
			@params = case params
			when Hash
				create_from params
			when String
				params
			else
				raise "Must be a Hash or String, was #{arg}"
			end
		end

		# encode after encryption to ensure Base64 compatibility in link
		def encoded
			@encoded ||= Base64.encode64 encrypted_params
		end

		protected

		def encrypted_params
			crypter.encrypt(params)
		end

		# {:a => b, :c = 2} -> a=b&c=2
		def create_from arg
			@params = arg.inject([]) do |res, hash| 
				res << [hash.first, hash.last].join('=')
				res
			end.join('&')
		end		

		def crypter
			Crypter.instance
		end
	end
end