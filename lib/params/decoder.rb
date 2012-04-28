module Params
	class Decoder
		attr_reader :params, :hash

		def initialize params
			raise "No profile params" if !params || params.empty?
			@params = params
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

		# decode in reverse order!
		def decoded
			@decoded ||= crypter.decrypt decoded_params
		end

		protected

		def decoded_params
			Base64.decode64(params)
		end

		def crypter
			Crypter.instance
		end		
	end
end