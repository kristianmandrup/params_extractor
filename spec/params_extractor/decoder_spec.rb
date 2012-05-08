require 'spec_helper'
require 'decoder_ex'

describe Params::Decoder do
  subject { decoder }
  
  let(:params) do
    {}
  end

  let(:encoder) { Params::Encoder.new data, params }
  let(:decoder) { Params::Decoder.new encoded }
  let(:encoded) do
    encoder.encoded
  end

  let(:data) do 
    {:id => '7', :name => 'kris', :lang => 'na'}
  end

  let(:decoded_data) do
    {'id' => '7', 'name' => 'kris', 'lang' => 'na'}
  end

  let(:decoded_clean_data) do
    {'id' => '7', 'name' => 'kris', 'lang' => nil}
  end

  describe 'crypter?' do
    specify { subject.crypter?.should be_true }
  end

  describe 'use_crypter?' do
    specify { subject.use_crypter?.should be_true }
  end

  describe 'decode' do  
    it_behaves_like 'a decoder'
  end

  context 'Global Crypter turned off' do
    before :each do
      Params::Crypter.off!
    end

    describe 'decode' do
      it_behaves_like 'a decoder'
    end   
  end

  context 'Decoder crypter turned off' do
    let(:params) do
      {:crypter => false}
    end

    describe 'decode' do
      it_behaves_like 'a decoder'
    end
  end 

  context 'Decoder crypter turned off after init' do
    before :each do
      subject.crypter_off!
    end

    describe 'crypter?' do
      specify { subject.crypter?.should be_false }
    end

    describe 'decode' do
      it_behaves_like 'a decoder'
    end
  end 

  context 'Decoder crypter turned back on after init' do
    let(:params) do
      {:crypter => false}
    end

    before :each do
      subject.crypter_on!
    end

    describe 'crypter?' do
      specify { subject.crypter?.should be_true }
    end

    describe 'decode' do
      it_behaves_like 'a decoder'
    end
  end 

end
