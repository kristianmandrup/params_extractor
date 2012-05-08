module Params
	class Decoder 
		include Params::Base
		
		attr_reader :params, :hash

		def initialize *args
			raise "Decoder needs params to encode" if !args || args.empty?
			args = args.flatten
			options 	= args.last
			if options.kind_of? Hash			
				@crypter 	= options.delete(:crypter) if options				
			end

			@params = args.first
		end

		# fx decoder.as_hash['a'] returns value of a
		def as_hash mode = :str			
			@hash ||= Hash[decoded.split('&').collect{|p| p.split("=")}]
			case mode
			when :sym
				Hash[hash.map{ |k, v| [k.to_sym, v] }]
			else
				hash
			end
		end

		def as_clean_hash mode = :str
			clean_params(as_hash mode)
		end

		# decode in reverse order!
		def decoded
			@decoded ||= use_crypter? ? crypter.decrypt(decoded_params) : decoded_params
		end

		protected

		def decoded_params
			Base64.decode64(params)
		end

		def crypter
			Crypter.instance if crypter?
		end		
	end
end