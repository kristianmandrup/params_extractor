module Params
  module Base
    def clean_params params
      Hash[params.collect do |key, value|
        value = nil if value == "na"
        [key, value]
        end
      ]
    end

    def use_crypter?
      crypter? || Params::Crypter.on?
    end

    def crypter?
      !(@crypter == false)
    end

    def crypter_off!
      @crypter = false
    end

    def crypter_on!
      @crypter = true
    end
  end
end