shared_examples 'a decoder' do
  specify { subject.decoded.should_not == data}

  specify do 
    subject.as_hash.should == decoded_data
  end

  specify do 
    subject.as_clean_hash.should == decoded_clean_data
  end

  specify { subject.as_hash(:sym).should == data }
end