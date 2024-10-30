# frozen_string_literal: true

# test/chatgpt/errors_test.rb
require "test_helper"

class TestChatGPTErrors < Minitest::Test
  def test_api_error_with_status_code
    error = ChatGPT::APIError.new("Test error", 404, "not_found")
    assert_equal 404, error.status_code
    assert_equal "not_found", error.error_type
    assert_equal "Test error", error.message
  end

  def test_authentication_error
    error = ChatGPT::AuthenticationError.new("Invalid API key")
    assert_instance_of ChatGPT::AuthenticationError, error
    assert_equal "Invalid API key", error.message
  end
end
