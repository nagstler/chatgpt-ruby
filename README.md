# ChatGPT Ruby

[![Gem Version](https://badge.fury.io/rb/chatgpt-ruby.svg)](https://badge.fury.io/rb/chatgpt-ruby)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Maintainability](https://api.codeclimate.com/v1/badges/08c7e7b58e9fbe7156eb/maintainability)](https://codeclimate.com/github/nagstler/chatgpt-ruby/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/08c7e7b58e9fbe7156eb/test_coverage)](https://codeclimate.com/github/nagstler/chatgpt-ruby/test_coverage)
[![CI](https://github.com/nagstler/chatgpt-ruby/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/nagstler/chatgpt-ruby/actions/workflows/ci.yml)

A comprehensive Ruby SDK for OpenAI's GPT APIs, providing a robust, feature-rich interface for AI-powered applications.

📚 [Check out the Integration Guide](https://github.com/nagstler/chatgpt-ruby/wiki) to get started!

## Features

- 🚀 Full support for GPT-3.5-Turbo and GPT-4 models
- 📡 Streaming responses support
- 🔧 Function calling and JSON mode
- 🎨 DALL-E image generation
- 🔄 Fine-tuning capabilities
- 📊 Token counting and validation
- ⚡ Async operations support
- 🛡️ Built-in rate limiting and retries
- 🎯 Type-safe responses
- 📝 Comprehensive logging

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
- [Core Features](#core-features)
  - [Chat Completions](#chat-completions)
  - [Function Calling](#function-calling)
  - [Image Generation (DALL-E)](#image-generation-dall-e)
  - [Fine-tuning](#fine-tuning)
  - [Token Management](#token-management)
  - [Error Handling](#error-handling)
- [Advanced Usage](#advanced-usage)
  - [Async Operations](#async-operations)
  - [Batch Operations](#batch-operations)
  - [Response Objects](#response-objects)
- [Development](#development)
- [Contributing](#contributing)
- [License](#license)

## Installation

Add to your Gemfile:

```ruby
gem 'chatgpt-ruby'
```

Or install directly:

```bash
$ gem install chatgpt-ruby
```

## Quick Start

```ruby
require 'chatgpt'

# Initialize with API key
client = ChatGPT::Client.new(api_key: 'your-api-key')

# Simple chat completion
response = client.chat(messages: [
  { role: "user", content: "What is Ruby?" }
])

puts response.content
```

## Configuration

```ruby
ChatGPT.configure do |config|
  config.api_key = 'your-api-key'
  config.default_model = 'gpt-4'
  config.timeout = 30
  config.max_retries = 3
  config.api_version = '2024-01'
end
```

## Core Features

### Chat Completions

```ruby
# Basic chat
client.chat(messages: [
  { role: "system", content: "You are a helpful assistant." },
  { role: "user", content: "Hello!" }
])

# With streaming
client.chat_stream(messages: [...]) do |chunk|
  print chunk.content
end
```

### Function Calling

```ruby
functions = [
  {
    name: "get_weather",
    description: "Get current weather",
    parameters: {
      type: "object",
      properties: {
        location: { type: "string" },
        unit: { type: "string", enum: ["celsius", "fahrenheit"] }
      }
    }
  }
]

response = client.chat(
  messages: [{ role: "user", content: "What's the weather in London?" }],
  functions: functions,
  function_call: "auto"
)
```

### Image Generation (DALL-E)

```ruby
# Generate image
image = client.images.generate(
  prompt: "A sunset over mountains",
  size: "1024x1024",
  quality: "hd"
)

# Create variations
variation = client.images.create_variation(
  image: File.read("input.png"),
  n: 1
)
```

### Fine-tuning

```ruby
# Create fine-tuning job
job = client.fine_tunes.create(
  training_file: "file-abc123",
  model: "gpt-3.5-turbo"
)

# List fine-tuning jobs
jobs = client.fine_tunes.list

# Get job status
status = client.fine_tunes.retrieve(job.id)
```

### Token Management

```ruby
# Count tokens
count = client.tokens.count("Your text here", model: "gpt-4")

# Validate token limits
client.tokens.validate_messages(messages, max_tokens: 4000)
```

### Error Handling

```ruby
begin
  response = client.chat(messages: [...])
rescue ChatGPT::RateLimitError => e
  puts "Rate limit hit: #{e.message}"
rescue ChatGPT::APIError => e
  puts "API error: #{e.message}"
rescue ChatGPT::TokenLimitError => e
  puts "Token limit exceeded: #{e.message}"
end
```

## Advanced Usage

### Async Operations

```ruby
client.async do
  response1 = client.chat(messages: [...])
  response2 = client.chat(messages: [...])
  [response1, response2]
end
```

### Batch Operations

```ruby
responses = client.batch do |batch|
  batch.add_chat(messages: [...])
  batch.add_chat(messages: [...])
end
```

### Response Objects

```ruby
response = client.chat(messages: [...])

response.content  # Main response content
response.usage   # Token usage information
response.finish_reason  # Why the response ended
response.model   # Model used
```

## Development

```bash
# Run tests
bundle exec rake test

# Run linter
bundle exec rubocop

# Generate documentation
bundle exec yard doc
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b feature/my-new-feature`)
3. Add tests for your feature
4. Make your changes
5. Commit your changes (`git commit -am 'Add some feature'`)
6. Push to the branch (`git push origin feature/my-new-feature`)
7. Create a new Pull Request

## License

Released under the MIT License. See [LICENSE](LICENSE.txt) for details.
