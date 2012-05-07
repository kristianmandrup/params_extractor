shared_examples 'an encoder' do
  specify { subject.encoded.should_not == data }
end