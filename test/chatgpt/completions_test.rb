require 'minitest/autorun'
require 'chatgpt/client'

class TestChatGPTCompletions < Minitest::Test
  def setup
    api_key = ENV['API_KEY']
    @client = ChatGPT::Client.new(api_key)
  end

  def test_completions_returns_valid_response
    prompt = "Hello, my name is"
    response = @client.completions(prompt)

    assert response["choices"].length > 0
    assert response["choices"][0]["text"] != nil
  end

  def test_completions_with_custom_params
    prompt = "Hello, my name is"
    params = {
      engine: "davinci",
      max_tokens: 10,
      temperature: 0.7
    }
    response = @client.completions(prompt, params)

    assert response["choices"].length > 0
    assert response["choices"][0]["text"] != nil
  end

  def test_completions_with_invalid_api_key
    invalid_api_key = 'invalid_api_key'
    invalid_client = ChatGPT::Client.new(invalid_api_key)
  
    prompt = "Hello, my name is"
  
    assert_raises(RestClient::ExceptionWithResponse) do
        invalid_client.completions(prompt)
    end
  end
end
