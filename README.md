# Params extractor

Used to encode or decode a URL params. This is useful for sending out encrypted links with token and then unencrypting, decoding and parsing them later when they come back to the app.

## Getting started example

```ruby
	# singleton Crypter shared between Encoder and Decoder (uses 'gibberish' gem)
	# Recommended: load password from a DB table, YAML file or similar

	Params::Crypter.password = "my very secret password"

	# encrypt and encode the params
	params = {:id => 7, :name => 'kris'}

	encoder = Params::Encoder.new(params)
	encoder.params # => 'id=7&name=kris'  

	encoded_params = encoder.encoded

	email_link = "#{domain}/invite?token=" + encoded_params

	# send link in email or Facebook notification or similar

	# later... someone clicks on the link

	# decrypt and decode the params
	decoded_params = Params::Decoder.new(params).decoded

	# retrieve hash from param values
	hash = decoded_params.as_hash(:sym)
	
	# retrieve param values from hash
	id 		= hash[:id].to_i
	name 	= hash[:name]
```

Look at the specs for more on usage. 

## Contributing to params_extractor
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2012 Kristian Mandrup. See LICENSE.txt for
further details.
