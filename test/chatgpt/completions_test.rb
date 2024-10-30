# test/chatgpt/completions_test.rb
require 'test_helper'

class TestChatGPTCompletionsIntegration < Minitest::Test
  include TestHelpers

  def setup
    @api_key = 'test-key'
    @client = ChatGPT::Client.new(@api_key)
  end

  def test_completions_returns_valid_response
    stub_completions_request
    response = @client.completions("Hello, my name is")
    assert_equal 1, response["choices"].length
    assert response["choices"][0]["text"]
  end

  def test_completions_with_custom_params
    stub_completions_request(n: 2)
    custom_params = {
      engine: "text-davinci-002",
      max_tokens: 10,
      temperature: 0.7,
      top_p: 0.9,
      n: 2
    }
    
    response = @client.completions("Hello, my name is", custom_params)
    assert_equal 2, response["choices"].length
  end

  def test_completions_with_custom_n_parameter
    stub_completions_request(n: 3)
    response = @client.completions("Hello, my name is", { n: 3 })
    assert_equal 3, response["choices"].length
  end

  def test_completions_returns_error_with_invalid_engine
    stub_error_request(404, "Model not found")
    error = assert_raises(ChatGPT::APIError) do
      @client.completions("Hello", { engine: "invalid-engine" })
    end
    assert_equal "Model not found", error.message
    assert_equal 404, error.status_code
  end

  def test_completions_returns_error_with_invalid_max_tokens
    stub_error_request(400, "Invalid max_tokens")
    error = assert_raises(ChatGPT::InvalidRequestError) do
      @client.completions("Hello", { max_tokens: -10 })
    end
    assert_equal "Invalid max_tokens", error.message
    assert_equal 400, error.status_code
  end

  def test_completions_returns_error_with_invalid_api_key
    stub_error_request(401, "Invalid API key")
    error = assert_raises(ChatGPT::AuthenticationError) do
      @client.completions("Hello")
    end
    assert_equal "Invalid API key", error.message
    assert_equal 401, error.status_code
  end

  def test_completions_returns_error_with_rate_limit
    stub_error_request(429, "Rate limit exceeded")
    error = assert_raises(ChatGPT::RateLimitError) do
      @client.completions("Hello")
    end
    assert_equal "Rate limit exceeded", error.message
    assert_equal 429, error.status_code
  end
end