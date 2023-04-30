require 'minitest/autorun'
require 'chatgpt/client'

class TestChatGPTClassify < Minitest::Test
  def setup
    api_key = ENV['API_KEY']
    @client = ChatGPT::Client.new(api_key)
  end

  def test_classify_returns_valid_response
    text = "Is this a valid question?"

    response_body = {
      "data" => [
        {
          "label": "Valid Question"
        }
      ]
    }

    response_object = RestClient::Response.new(response_body.to_json)

    RestClient.stub :post, response_object do
      response = @client.classify(text)
      refute_nil response
      assert_equal "Valid Question", response
    end
  end

  def test_classify_with_custom_params
    text = "Is this a valid question?"
    params = { model: 'text-davinci-002' }

    response_body = {
      "data" => [
        {
          "label": "Valid Question"
        }
      ]
    }

    response_object = RestClient::Response.new(response_body.to_json)

    RestClient.stub :post, response_object do
      response = @client.classify(text, params)
      refute_nil response
      assert_equal "Valid Question", response
    end
  end
end
