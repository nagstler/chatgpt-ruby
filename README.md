# ChatGPTRuby

The `chatgpt-ruby` gem is a simple Ruby SDK for accessing the OpenAI ChatGPT API. This client makes it easy to integrate the ChatGPT API into your Ruby applications.

### Bundler

Add this line to your application's Gemfile:

```ruby
gem "chatgpt-ruby"
```

And then execute:

$ bundle install

### Gem install

Or install with:

$ gem install chatgpt-ruby

## Usage

To use the gem in a Ruby script or application, simply require it and initialize the client:
```ruby
require 'chatgpt_client'

client = ChatGPTClient::Client.new('your_api_key')
response = client.chat('Please translate the following English text to French: "Hello, how are you?"')
puts response
```

Replace 'your_api_key' with your actual ChatGPT API key.

### Parameters

The `chat` method accepts a mandatory `prompt` parameter and an optional `options` parameter.

The `prompt` parameter is a string representing the input you want to send to the ChatGPT API.

The `options` parameter is a hash that can include the following keys: 
- `max_tokens`: The maximum number of tokens

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/chatgpt-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/chatgpt-ruby/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Chatgpt::Ruby project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/chatgpt-ruby/blob/main/CODE_OF_CONDUCT.md).
