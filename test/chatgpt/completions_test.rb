require 'minitest/autorun'
require 'chatgpt/client'

class TestChatGPTCompletions < Minitest::Test
  def setup
    api_key = ENV['API_KEY']
    @client = ChatGPT::Client.new(api_key)
  end

  def test_completions_returns_valid_response
    prompt = "Hello, my name is"
    response_body = {
      "choices" => [
        {
          "text" => " John."
        }
      ]
    }
  
    response_object = RestClient::Response.new(response_body.to_json)
  
    RestClient.stub :post, response_object do
      response = @client.completions(prompt)
      assert response["choices"].length > 0
      assert response["choices"][0]["text"] != nil
    end
  end
  
  def test_completions_with_custom_params
    prompt = "Hello, my name is"
    params = {
      engine: "davinci",
      max_tokens: 10,
      temperature: 0.7
    }
    response_body = {
      "choices" => [
        {
          "text" => " John."
        }
      ]
    }
  
    response_object = RestClient::Response.new(response_body.to_json)
  
    RestClient.stub :post, response_object do
      response = @client.completions(prompt, params)
      assert response["choices"].length > 0
      assert response["choices"][0]["text"] != nil
    end
  end
  
  
  
  # def test_completions_with_custom_params
  #   prompt = "Hello, my name is"
  #   params = {
  #     engine: "davinci",
  #     max_tokens: 10,
  #     temperature: 0.7
  #   }
  #   response_body = {
  #     "choices" => [
  #       {
  #         "text" => " John."
  #       }
  #     ]
  #   }
  
  #   RestClient.stub :post, response_body.to_json do
  #     response = @client.completions(prompt, params)
  #     parsed_response = JSON.parse(response)
  #     assert parsed_response["choices"].length > 0
  #     assert parsed_response["choices"][0]["text"] != nil
  #   end
  # end
  

  # def test_completions_with_invalid_api_key
  #   invalid_api_key = 'invalid_api_key'
  #   invalid_client = ChatGPT::Client.new(invalid_api_key)

  #   prompt = "Hello, my name is"

  #   error_response = RestClient::Response.new('{"error": {"message": "Invalid API Key"}}', 401, {})
  #   exception = RestClient::ExceptionWithResponse.new(error_response)

  #   RestClient.stub :post, ->(*args) { raise exception } do
  #     assert_raises(RestClient::ExceptionWithResponse) do
  #       invalid_client.completions(prompt)
  #     end
  #   end
  # end
end
