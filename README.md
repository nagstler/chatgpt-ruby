# ChatGPT Ruby

[![Gem Version](https://badge.fury.io/rb/chatgpt-ruby.svg)](https://badge.fury.io/rb/chatgpt-ruby) [![License](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) [![Coverage Status](https://coveralls.io/repos/github/nagstler/chatgpt-ruby/badge.svg?branch=main)](https://coveralls.io/github/nagstler/chatgpt-ruby?branch=main) [![CI](https://github.com/nagstler/chatgpt-ruby/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/nagstler/chatgpt-ruby/actions/workflows/ci.yml)

The `chatgpt-ruby` is a Ruby SDK for the OpenAI API, including methods for generating text, completing prompts, and more ❤️

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


### Completions

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


### Search

To perform a search query given a set of documents and a search query, you can use the `search` method:

```ruby
documents = ['Document 1', 'Document 2', 'Document 3']
query = 'Search query'
results = client.search(documents, query)

# Output: an array of search result objects
```



You can customize the search process by passing in additional parameters as a hash:

```ruby
params = {
  engine: 'ada',
  max_rerank: 100
}
results = client.search(documents, query, params)

# Output: an array of search result objects
```


### Classify

To classify a given text, you can use the `classify` method:

```ruby
text = 'This is a sample text'
label = client.classify(text)

# Output: a string representing the classified label
```



You can customize the classification process by passing in additional parameters as a hash:

```ruby
params = {
  model: 'text-davinci-002'
}
label = client.classify(text, params)

# Output: a string representing the classified label
```


### Generate Summaries

To generate summaries given a set of documents, you can use the `generate_summaries` method:

```ruby
documents = ['Document 1', 'Document 2', 'Document 3']
summary = client.generate_summaries(documents)

# Output: a string representing the generated summary
```



You can customize the summary generation process by passing in additional parameters as a hash:

```ruby
params = {
  model: 'text-davinci-002',
  max_tokens: 100
}
summary = client.generate_summaries(documents, params)

# Output: a string representing the generated summary
```


### Generate Answers

To generate answers given a prompt and a set of documents, you can use the `generate_answers` method:

```ruby
prompt = 'What is the capital of France?'
documents = ['France is a country in Europe', 'Paris is the capital of France']
answer = client.generate_answers(prompt, documents)

# Output
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
