require 'minitest/autorun'
require 'chatgpt/client'

class TestChatGPTGenerateAnswers < Minitest::Test
  def setup
    api_key = ENV['API_KEY']
    @client = ChatGPT::Client.new(api_key)
  end

  def test_generate_answers_returns_valid_response
    prompt = "What is the capital of France?"
    documents = ["Paris is the capital of France.", "France is a country in Europe."]

    response_body = {
      "data" => [
        {
          "answer" => "Paris"
        }
      ]
    }

    response_object = RestClient::Response.new(response_body.to_json)

    RestClient.stub :post, response_object do
      response = @client.generate_answers(prompt, documents)
      refute_nil response
      assert_equal "Paris", response
    end
  end

  def test_generate_answers_with_custom_params
    prompt = "What is the capital of France?"
    documents = ["Paris is the capital of France.", "France is a country in Europe."]
    params = { model: 'text-davinci-002', max_tokens: 10 }

    response_body = {
      "data" => [
        {
          "answer" => "Paris"
        }
      ]
    }

    response_object = RestClient::Response.new(response_body.to_json)

    RestClient.stub :post, response_object do
      response = @client.generate_answers(prompt, documents, params)
      refute_nil response
      assert_equal "Paris", response
    end
  end
end
