require 'minitest/autorun'
require 'chatgpt/client'

class TestChatGPTSearch < Minitest::Test
  def setup
    api_key = ENV['API_KEY']
    @client = ChatGPT::Client.new(api_key)
  end

  def test_search_returns_valid_response
    documents = ["Apple", "Orange", "Banana", "Grape"]
    query = "fruit"

    response_body = {
      "data" => [
        {"id": "0", "score": 1.0},
        {"id": "1", "score": 0.5},
        {"id": "2", "score": 0.3},
        {"id": "3", "score": 0.2}
      ]
    }

    response_object = RestClient::Response.new(response_body.to_json)

    RestClient.stub :post, response_object do
      response = @client.search(documents, query)
      assert_equal 4, response.length
      assert response[0]['id']
      assert response[0]['score']
    end
  end

  def test_search_with_custom_params
    documents = ["Apple", "Orange", "Banana", "Grape"]
    query = "fruit"
    params = { engine: 'davinci', max_rerank: 100 }

    response_body = {
      "data" => [
        {"id": "0", "score": 1.0},
        {"id": "1", "score": 0.5},
        {"id": "2", "score": 0.3},
        {"id": "3", "score": 0.2}
      ]
    }

    response_object = RestClient::Response.new(response_body.to_json)

    RestClient.stub :post, response_object do
      response = @client.search(documents, query, params)
      assert_equal 4, response.length
      assert response[0]['id']
      assert response[0]['score']
    end
  end
end
