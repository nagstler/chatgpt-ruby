# frozen_string_literal: true

# test/chatgpt/configuration_test.rb
require 'test_helper'

class TestChatGPTConfiguration < Minitest::Test
  def setup
    ChatGPT.reset_configuration!
  end

  def teardown
    ChatGPT.reset_configuration!
  end

  def test_global_configuration
    ChatGPT.configure do |config|
      config.api_key = 'test-key'
      config.default_engine = 'custom-engine'
      config.request_timeout = 60
    end

    assert_equal 'test-key', ChatGPT.configuration.api_key
    assert_equal 'custom-engine', ChatGPT.configuration.default_engine
    assert_equal 60, ChatGPT.configuration.request_timeout
  end

  def test_default_configuration_values
    config = ChatGPT.configuration

    assert_equal 'v1', config.api_version
    assert_equal 'gpt-4o-mini', config.default_engine
    assert_equal 30, config.request_timeout
    assert_equal 3, config.max_retries
    assert_kind_of Hash, config.default_parameters
  end

  def test_configuration_can_be_reset
    ChatGPT.configure { |config| config.api_key = 'test-key' }
    ChatGPT.reset_configuration!
    assert_nil ChatGPT.configuration.api_key
  end

  def test_default_parameters
    config = ChatGPT.configuration
    default_params = config.default_parameters

    assert_equal 16, default_params[:max_tokens]
    assert_equal 0.5, default_params[:temperature]
    assert_equal 1.0, default_params[:top_p]
    assert_equal 1, default_params[:n]
  end
end
