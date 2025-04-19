# ChatGPT Ruby

<a href="https://badge.fury.io/rb/chatgpt-ruby"><img src="https://img.shields.io/gem/v/chatgpt-ruby?style=for-the-badge" alt="Gem Version"></a>
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge" alt="License"></a>
<a href="https://codeclimate.com/github/nagstler/chatgpt-ruby/test_coverage"><img src="https://img.shields.io/codeclimate/coverage/nagstler/chatgpt-ruby?style=for-the-badge" alt="Test Coverage"></a>
<a href="https://github.com/nagstler/chatgpt-ruby/actions/workflows/ci.yml"><img src="https://img.shields.io/github/actions/workflow/status/nagstler/chatgpt-ruby/ci.yml?branch=main&style=for-the-badge" alt="CI"></a>
<a href="https://github.com/nagstler/chatgpt-ruby/stargazers"><img src="https://img.shields.io/github/stars/nagstler/chatgpt-ruby?style=for-the-badge" alt="GitHub stars"></a>

🤖💎 A lightweight Ruby wrapper for the OpenAI API, designed for simplicity and ease of integration.

## Features

- API integration for chat completions and text completions
- Streaming capability for handling real-time response chunks
- Custom exception classes for different API error types
- Configurable timeout, retries and default parameters
- Complete test suite with mocked API responses

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
- [Rails Integration](#rails-integration)
- [Error Handling](#error-handling)
- [Current Capabilities](#current-capabilities)
  - [Chat Completions](#chat-completions)
  - [Text Completions](#text-completions)
- [Roadmap](#roadmap)
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
client = ChatGPT::Client.new(ENV['OPENAI_API_KEY'])

# Chat API (Recommended for GPT-3.5-turbo, GPT-4)
response = client.chat([
  { role: "user", content: "What is Ruby?" }
])

puts response.dig("choices", 0, "message", "content")

# Completions API (For GPT-3.5-turbo-instruct)
response = client.completions("What is Ruby?")
puts response.dig("choices", 0, "text")

```

## Rails Integration

In a Rails application, create an initializer:

```ruby
# config/initializers/chat_gpt.rb
require 'chatgpt'

ChatGPT.configure do |config|
  config.api_key = Rails.application.credentials.openai[:api_key]
  config.default_engine = 'gpt-3.5-turbo'
  config.request_timeout = 30
end
```
Then use it in your controllers or services:

```ruby
# app/services/chat_gpt_service.rb
class ChatGPTService
  def initialize
    @client = ChatGPT::Client.new
  end
  
  def ask_question(question)
    response = @client.chat([
      { role: "user", content: question }
    ])
    
    response.dig("choices", 0, "message", "content")
  end
end

# Usage in controller
def show
  service = ChatGPTService.new
  @response = service.ask_question("Tell me about Ruby on Rails")
end
```

## Configuration

```ruby
ChatGPT.configure do |config|
  config.api_key = ENV['OPENAI_API_KEY']
  config.api_version = 'v1'
  config.default_engine = 'gpt-3.5-turbo'
  config.request_timeout = 30
  config.max_retries = 3
  config.default_parameters = {
    max_tokens: 16,
    temperature: 0.5,
    top_p: 1.0,
    n: 1
  }
end
```

## Error handling

```ruby
begin
  response = client.chat([
    { role: "user", content: "Hello!" }
  ])
rescue ChatGPT::AuthenticationError => e
  puts "Authentication error: #{e.message}"
rescue ChatGPT::RateLimitError => e
  puts "Rate limit hit: #{e.message}"
rescue ChatGPT::InvalidRequestError => e
  puts "Bad request: #{e.message}"
rescue ChatGPT::APIError => e
  puts "API error: #{e.message}"
end
```

## Current Capabilities

### Chat Completions
```ruby
# Basic chat
response = client.chat([
  { role: "user", content: "What is Ruby?" }
])

# With streaming
client.chat_stream([{ role: "user", content: "Tell me a story" }]) do |chunk|
  print chunk.dig("choices", 0, "delta", "content")
end
```

### Text Completions
```ruby
# Basic completion with GPT-3.5-turbo-instruct
response = client.completions("What is Ruby?")
puts response.dig("choices", 0, "text")
```

## Roadmap

While ChatGPT Ruby is functional, there are several areas planned for improvement:

- [ ] Response object wrapper & Rails integration with Railtie (v2.2)
- [ ] Token counting, function calling, and rate limiting (v2.3)
- [ ] Batch operations and async support (v3.0)
- [ ] DALL-E image generation and fine-tuning (Future)

❤️ Contributions in any of these areas are welcome!

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
