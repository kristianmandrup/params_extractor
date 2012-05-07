module Params
  module Base
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