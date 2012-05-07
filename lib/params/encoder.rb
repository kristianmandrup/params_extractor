module Params
	class Encoder
		include Params::Base

		attr_reader :params

		def initialize *args
			raise "Encoder needs params to encode" if !args || args.empty?
			args = args.flatten
			options = args.last 
			if options.kind_of? Hash				
				@crypter = options.delete(:crypter)
			end
			arg = args.first
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
			@encoded ||= use_crypter? ? Base64.encode64(encrypted_params) : Base64.encode64(params)
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
			Crypter.instance if crypter?
		end
	end
end