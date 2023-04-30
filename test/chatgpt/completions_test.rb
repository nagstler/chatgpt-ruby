require 'minitest/autorun'
require 'chatgpt/client'

class TestChatGPTCompletions < Minitest::Test
  def setup
    api_key = ENV['API_KEY']
    @client = ChatGPT::Client.new(api_key)
  end

  def test_completions_returns_valid_response
    prompt = "Hello, my name is"
    engine = "text-davinci-002"
    response_body = {
      "choices" => [
        {
          "text" => " John."
        }
      ]
    }

    response_object = RestClient::Response.new(response_body.to_json)
    url = "#{@client.instance_variable_get(:@endpoint)}/engines/#{engine}/completions"

    RestClient.stub(:post, response_object) do
      RestClient::Request.stub(:execute, response_object) do
        response = @client.completions(prompt)
        assert response["choices"].length > 0
        assert response["choices"][0]["text"] != nil
      end
    end
  end
  
  def test_completions_with_custom_params
    prompt = "Hello, my name is"
    engine = "text-davinci-002"
    custom_params = {
      engine: engine,
      max_tokens: 10,
      temperature: 0.7,
      top_p: 0.9,
      n: 2
    }
    response_body = {
      "choices" => [
        {
          "text" => " John."
        },
        {
          "text" => " Jane."
        }
      ]
    }

    response_object = RestClient::Response.new(response_body.to_json)
    url = "#{@client.instance_variable_get(:@endpoint)}/engines/#{engine}/completions"

    RestClient.stub(:post, response_object) do
      RestClient::Request.stub(:execute, response_object) do
        response = @client.completions(prompt, custom_params)
        assert_equal 2, response["choices"].length
        assert response["choices"][0]["text"] != nil
        assert response["choices"][1]["text"] != nil
      end
    end
  end

  def test_completions_returns_valid_response_when_prompt_is_empty
    empty_prompt = ""
    engine = "text-davinci-002"
    response_body = {
      "choices" => [
        {
          "text" => "Random text."
        }
      ]
    }

    response_object = RestClient::Response.new(response_body.to_json)
    url = "#{@client.instance_variable_get(:@endpoint)}/engines/#{engine}/completions"

    RestClient.stub(:post, response_object) do
      RestClient::Request.stub(:execute, response_object) do
        response = @client.completions(empty_prompt)
        assert_equal 1, response["choices"].length
        assert response["choices"][0]["text"] != nil
      end
    end
  end
  
  def test_completions_with_custom_n_parameter
    prompt = "Hello, my name is"
    engine = "text-davinci-002"
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
    url = "#{@client.instance_variable_get(:@endpoint)}/engines/#{engine}/completions"

    RestClient.stub(:post, response_object) do
      RestClient::Request.stub(:execute, response_object) do
        response = @client.completions(prompt, params)
        assert_equal 3, response["choices"].length
      end
    end
  end
  

end
