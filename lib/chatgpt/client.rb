require 'rest-client'
require 'json'

module ChatGPT
  class Client
    def initialize(api_key)
      @api_key = api_key
      @endpoint = 'https://api.openai.com/v1'
    end

    # Helper method to prepare headers
    def headers
      {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{@api_key}"
      }
    end

    # Completion-related methods
    def completions(prompt, params = {})
      engine = params[:engine] || 'text-davinci-002'
      max_tokens = params[:max_tokens] || 16
      temperature = params[:temperature] || 0.5
      top_p = params[:top_p] || 1.0
      n = params[:n] || 1

      url = "#{@endpoint}/engines/#{engine}/completions"
      data = {
        prompt: prompt,
        max_tokens: max_tokens,
        temperature: temperature,
        top_p: top_p,
        n: n
      }
      request_api(url, data)
    end

    # List models
    def list_models
      url = "#{@endpoint}/models"
      response = request_api(url, {}, :get)
      response['data']
    end

    # Retrieve a specific model
    def retrieve_model(id)
      url = "#{@endpoint}/models/#{id}"
      response = request_api(url, {}, :get)
      response['data']
    end


    private

    # Helper method to make API requests
    def request_api(url, data, method = :post)
      begin
        response = RestClient::Request.execute(method: method, url: url, payload: data.to_json, headers: headers)
        JSON.parse(response.body)
      rescue RestClient::ExceptionWithResponse => e
        error_msg = JSON.parse(e.response.body)['error']['message']
        raise RestClient::ExceptionWithResponse.new("#{e.message}: #{error_msg} (#{e.http_code})"), nil, e.backtrace
      end
    end
    
  end
end
