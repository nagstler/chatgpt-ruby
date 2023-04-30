require 'minitest/autorun'
require 'chatgpt/client'

class TestChatGPTGenerateSummaries < Minitest::Test
  def setup
    api_key = ENV['API_KEY']
    @client = ChatGPT::Client.new(api_key)
  end

  def test_generate_summaries_returns_valid_response
    documents = ["This is a long text about apples.", "This is another long text about oranges."]

    response_body = {
      "choices" => [
        {
          "text" => "Summary: Apples and oranges."
        }
      ]
    }

    response_object = RestClient::Response.new(response_body.to_json)

    RestClient.stub :post, response_object do
      response = @client.generate_summaries(documents)
      refute_nil response
      assert_equal "Summary: Apples and oranges.", response
    end
  end

  def test_generate_summaries_with_custom_params
    documents = ["This is a long text about apples.", "This is another long text about oranges."]
    params = {
      model: 'text-davinci-002',
      max_tokens: 30,
      temperature: 0.8,
      top_p: 1.0,
      frequency_penalty: 0.1,
      presence_penalty: 0.1
    }

    response_body = {
      "choices" => [
        {
          "text" => "Summary: Apples and oranges."
        }
      ]
    }

    response_object = RestClient::Response.new(response_body.to_json)

    RestClient.stub :post, response_object do
      response = @client.generate_summaries(documents, params)
      refute_nil response
      assert_equal "Summary: Apples and oranges.", response
    end
  end
end
