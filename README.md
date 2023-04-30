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

## Models

With the ChatGPT Ruby SDK, you can list and retrieve information about the available models, such as GPT-4, GPT-3, and other models provided by OpenAI.
### List Models

To list all available models, you can use the `list_models` method:

```ruby

models = client.list_models

# Output: an array of model objects, including information about GPT-4, GPT-3, and other models
```

Each model object in the array contains information about the model, such as its ID, name, description, and other attributes.
### Retrieve Model

To retrieve a specific model by its ID, you can use the `retrieve_model` method:

```ruby

model_id = 'text-gpt-4-001' # Replace with the desired model ID, e.g., 'text-gpt-3-001', 'text-davinci-002', etc.
model = client.retrieve_model(id: model_id)

# Output: a model object with detailed information about the requested model
```

The retrieved model object contains detailed information about the model, such as its ID, name, description, and other attributes.

Keep in mind that the actual model names and IDs provided by OpenAI may change, and you should refer to the [OpenAI API documentation](https://beta.openai.com/docs/)  for the most up-to-date list of available models.


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

# Output: an array of completion strings
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nagstler/chatgpt-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/nagstler/chatgpt-ruby/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Chatgpt::Ruby project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/nagstler/chatgpt-ruby/blob/main/CODE_OF_CONDUCT.md).
