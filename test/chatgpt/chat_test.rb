# frozen_string_literal: true

# test/chatgpt/chat_test.rb
require "test_helper"

class TestChatGPTChatIntegration < Minitest::Test
  include TestHelpers

  def setup
    @api_key = "test-key"
    @client = ChatGPT::Client.new(@api_key)
  end

  def test_basic_chat
    stub_chat_request
    messages = [{ role: "user", content: "Hello!" }]
    response = @client.chat(messages)

    assert_equal 1, response["choices"].length
    assert response["choices"][0]["message"]["content"]
    assert_equal "assistant", response["choices"][0]["message"]["role"]
  end

  def test_chat_with_system_message
    stub_chat_request
    messages = [
      { role: "system", content: "You are a helpful assistant." },
      { role: "user", content: "Hello!" }
    ]

    response = @client.chat(messages)
    assert response["choices"][0]["message"]["content"]
  end

  def test_chat_with_custom_parameters
    stub_chat_request(temperature: 0.7)
    messages = [{ role: "user", content: "Hello!" }]
    response = @client.chat(messages, temperature: 0.7)

    assert response["choices"][0]["message"]["content"]
  end

  def test_chat_streaming
    stub_chat_stream_request
    messages = [{ role: "user", content: "Hello!" }]
    chunks = []

    @client.chat_stream(messages) do |chunk|
      chunks << chunk
    end

    assert chunks.length.positive?
    assert chunks.all? { |c| c["choices"][0]["delta"] }
  end

  def test_chat_with_invalid_messages
    stub_chat_error_request(400, "Invalid messages format")
    error = assert_raises(ChatGPT::InvalidRequestError) do
      @client.chat([])
    end
    assert_equal 400, error.status_code
    assert_equal "Invalid messages format", error.message
  end

  def test_chat_with_rate_limit
    stub_chat_error_request(429, "Rate limit exceeded")
    error = assert_raises(ChatGPT::RateLimitError) do
      @client.chat([{ role: "user", content: "Hello!" }])
    end
    assert_equal 429, error.status_code
  end
end
