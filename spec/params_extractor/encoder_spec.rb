require 'spec_helper'
require 'encoder_ex'

describe Params::Encoder do
  subject { encoder }

  let(:params) do
    {}
  end

  let(:data) do 
    {:id => 7, :name => 'kris'}
  end

  let(:encoder) { Params::Encoder.new data, params }

  # before do
  #   Params::Crypter.on!
  # end

  describe 'crypter?' do
    specify { subject.crypter?.should be_true }
  end

  describe 'use_crypter?' do
    specify { subject.use_crypter?.should be_true }
  end

  describe 'encode' do
    specify { subject.encoded.should_not == data }
  end

  context 'Global Crypter turned off' do
    before do
      Params::Crypter.off!
    end

    it_behaves_like 'an encoder'
  end

  context 'Encoder crypter turned off' do
    let(:params) do
      {:crypter => false}
    end

    it_behaves_like 'an encoder'
  end 
end