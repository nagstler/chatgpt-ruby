require 'minitest/autorun'
require 'chatgpt/client'

class TestChatGPTCompletionsIntegration < Minitest::Test
  def setup
    @api_key = ENV['CHATGPT_API_KEY']  # Make sure to set this environment variable
    @client = ChatGPT::Client.new(@api_key)
  end

  def test_completions_returns_valid_response
    response = @client.completions("Hello, my name is")
    assert response["choices"].length > 0
    assert response["choices"][0]["text"] != nil
  end
  
  def test_completions_with_custom_params
    custom_params = {
      engine: "text-davinci-002",
      max_tokens: 10,
      temperature: 0.7,
      top_p: 0.9,
      n: 2
    }

    response = @client.completions("Hello, my name is", custom_params)
    assert_equal 2, response["choices"].length
    assert response["choices"][0]["text"] != nil
    assert response["choices"][1]["text"] != nil
  end

  def test_completions_returns_valid_response_when_prompt_is_empty
    response = @client.completions("")
    assert response["choices"].length > 0
    assert response["choices"][0]["text"] != nil
  end
  
  def test_completions_with_custom_n_parameter
    params = {
      n: 3
    }

    response = @client.completions("Hello, my name is", params)
    assert_equal 3, response["choices"].length
  end

  def test_completions_with_high_max_tokens
    custom_params = {
      max_tokens: 100
    }

    response = @client.completions("Hello, my name is", custom_params)
    assert response["choices"].length > 0
    assert response["choices"][0]["text"].split(' ').length <= 100
  end

  def test_completions_with_low_max_tokens
    custom_params = {
      max_tokens: 1
    }

    response = @client.completions("Hello, my name is", custom_params)
    assert response["choices"].length > 0
    assert response["choices"][0]["text"].split(' ').length <= 1
  end

  def test_completions_returns_error_with_invalid_engine
    prompt = "Hello, my name is"
    engine = "invalid-engine"
    assert_raises(RestClient::ExceptionWithResponse) do
      @client.completions(prompt, {engine: engine})
    end
  end

  def test_completions_returns_error_with_invalid_max_tokens
    prompt = "Hello, my name is"
    max_tokens = -10
    assert_raises(RestClient::ExceptionWithResponse) do
      @client.completions(prompt, {max_tokens: max_tokens})
    end
  end
end
