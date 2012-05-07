require 'spec_helper'

describe Params::Crypter do
  subject { crypter }

  let(:params) do
    {}
  end

  let(:crypter) { Params::Crypter.instance }
  let(:data)    { "a=5&b=7" }

  before do
    Params::Crypter.password = "secret"
  end

  describe 'on?' do
    specify { subject.on?.should be_true }
  end

  describe 'off?' do
    specify { subject.off?.should be_false }
  end

  describe 'encrypt' do
    specify { subject.encrypt(data).should_not == data }
  end

  describe 'decrypt' do
    let(:encrypted) do
      subject.encrypt(data)
    end
  
    specify { subject.decrypt(encrypted).should == data }
  end

  context 'Global Crypter turned off' do
    before do
      Params::Crypter.off!
    end

    specify { subject.encrypt(data).should == data }

    describe 'on?' do
      specify { subject.on?.should be_false }
    end

    describe 'off?' do
      specify { subject.off?.should be_true }
    end

    describe 'turn crypter back on' do
      before :each do
        Params::Crypter.on!
      end

      describe 'on?' do
        specify { subject.on?.should be_true }
      end

      describe 'off?' do
        specify { subject.off?.should be_false }
      end

      specify { subject.encrypt(data).should_not == data }
    end
  end 
end
