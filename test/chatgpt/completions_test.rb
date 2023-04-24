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

  def test_completions_returns_valid_response_when_prompt_is_empty
    empty_prompt = ""
  
    response_body = {
      "choices" => [
        {
          "text" => "John."
        }
      ]
    }
  
    response_object = RestClient::Response.new(response_body.to_json)
  
    RestClient.stub :post, response_object do
      response = @client.completions(empty_prompt)
      assert response["choices"].length > 0
      assert response["choices"][0]["text"] != nil
    end
  end
  
  def test_completions_with_custom_n_parameter
    prompt = "Hello, my name is"
    params = {
      n: 3
    }
    response_body = {
      "choices" => [
        {
          "text" => " John."
        },
        {
          "text" => " Jane."
        },
        {
          "text" => " Max."
        }
      ]
    }
  
    response_object = RestClient::Response.new(response_body.to_json)
  
    RestClient.stub :post, response_object do
      response = @client.completions(prompt, params)
      assert_equal 3, response["choices"].length
    end
  end
  

end
