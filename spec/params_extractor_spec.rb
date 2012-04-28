require 'spec_helper'

describe Params::Crypter do
	subject { crypter }

	let(:crypter) { Params::Crypter.instance }
	let(:data) 		{ "a=5&b=7" }

	before do
		Params::Crypter.password = "secret"
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
end

describe Params::Encoder do
	subject { encoder }

	let(:data) do 
		{:id => 7, :name => 'kris'}
	end

	let(:encoder) { Params::Encoder.new data }

	describe 'encode' do
		specify { subject.encoded.should_not == data }
	end
end

describe Params::Decoder do
	subject { decoder }

	let(:encoder) { Params::Encoder.new data }

	let(:data) do 
		{:id => '7', :name => 'kris'}
	end

	describe 'decode' do
		let(:encoded) do
			encoder.encoded
		end

		let(:decoder) { Params::Decoder.new encoded }
	
		specify { subject.decoded.should_not == data}

		specify do 
			subject.as_hash.should == {'id' => '7', 'name' => 'kris'}
		end

		specify { subject.as_hash(:sym).should == data }
	end
end
