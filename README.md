# ChatGPT Ruby

[![Gem Version](https://badge.fury.io/rb/chatgpt-ruby.svg)](https://badge.fury.io/rb/chatgpt-ruby) [![License](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) [![Maintainability](https://api.codeclimate.com/v1/badges/08c7e7b58e9fbe7156eb/maintainability)](https://codeclimate.com/github/nagstler/chatgpt-ruby/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/08c7e7b58e9fbe7156eb/test_coverage)](https://codeclimate.com/github/nagstler/chatgpt-ruby/test_coverage) [![CI](https://github.com/nagstler/chatgpt-ruby/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/nagstler/chatgpt-ruby/actions/workflows/ci.yml) [![GitHub contributors](https://img.shields.io/github/contributors/nagstler/chatgpt-ruby)](https://github.com/nagstler/chatgpt-ruby/graphs/contributors)

The `chatgpt-ruby` is a Ruby SDK for the OpenAI API, providing methods for generating text and completing prompts using the ChatGPT model.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'chatgpt-ruby'
```

And then execute:

```ruby
$ bundle install
```

Or install it yourself as:

```ruby
$ gem install chatgpt-ruby
```

## Usage

To use the ChatGPT API SDK, you will need an API key from OpenAI. You can obtain an API key by signing up for the [OpenAI API beta program](https://beta.openai.com/signup/) .

Once you have an API key, you can create a new `ChatGPT::Client` instance with your API key:

```ruby
require 'chatgpt/client'

api_key = 'your-api-key'
client = ChatGPT::Client.new(api_key)
```

## Completions

To generate completions given a prompt, you can use the `completions` method:

```ruby
prompt = 'Hello, my name is'
completions = client.completions(prompt)

# Output: an array of completion strings
```

You can customize the generation process by passing in additional parameters as a hash:

```ruby
params = {
  engine: 'text-davinci-002',
  max_tokens: 50,
  temperature: 0.7
}
completions = client.completions(prompt, params)

puts completions["choices"].map { |c| c["text"] }
# Output: an array of completion strings
```

## Chat

The `chat` method allows for a dynamic conversation with the GPT model. It requires an array of messages where each message is a hash with two properties: `role` and `content`.

`role` can be: 
- `'system'`: Used for instructions that guide the conversation. 
- `'user'`: Represents the user's input. 
- `'assistant'`: Represents the model's output.

`content` contains the text message from the corresponding role.

Here is how you would start a chat:

```ruby

# Define the conversation messages
messages = [
  {
    role: "system",
    content: "You are a helpful assistant."
  },
  {
    role: "user",
    content: "Who won the world series in 2020?"
  }
]

# Start a chat
response = client.chat(messages)
```

The response will be a hash containing the model's message(s). You can extract the assistant's message like this:

```ruby

puts response['choices'][0]['message']['content'] # Outputs the assistant's message
```

The conversation can be continued by extending the `messages` array and calling the `chat` method again:

```ruby

messages << {role: "user", content: "Tell me more about it."}

response = client.chat(messages)
puts response['choices'][0]['message']['content'] # Outputs the assistant's new message
```

With this method, you can build an ongoing conversation with the model.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nagstler/chatgpt-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/nagstler/chatgpt-ruby/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Chatgpt::Ruby project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/nagstler/chatgpt-ruby/blob/main/CODE_OF_CONDUCT.md).
