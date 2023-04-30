require 'minitest/autorun'
require 'chatgpt/client'

class TestChatGPTModels < Minitest::Test
  def setup
    api_key = ENV['API_KEY']
    @client = ChatGPT::Client.new(api_key)
  end

  def test_list_models_returns_valid_response
    response_body = {
      "data" => [
        {
          "id" => "text-davinci-002",
          "object" => "model",
          "created" => 1622621666,
          "status" => "ready"
        }
      ]
    }

    response_object = RestClient::Response.new(response_body.to_json)
    url = "#{@client.instance_variable_get(:@endpoint)}/models"

    RestClient.stub(:get, response_object) do
      RestClient::Request.stub(:execute, response_object) do
        response = @client.list_models
        assert response.length > 0
        assert response[0]["id"] != nil
      end
    end
  end

  def test_retrieve_model_returns_valid_response
    model_id = "text-davinci-002"
    response_body = {
      "data" => {
        "id" => model_id,
        "object" => "model",
        "created" => 1622621666,
        "status" => "ready"
      }
    }

    response_object = RestClient::Response.new(response_body.to_json)
    url = "#{@client.instance_variable_get(:@endpoint)}/models/#{model_id}"

    RestClient.stub(:get, response_object) do
      RestClient::Request.stub(:execute, response_object) do
        response = @client.retrieve_model(model_id)
        assert_equal model_id, response["id"]
        assert response["status"] != nil
      end
    end
  end
end
