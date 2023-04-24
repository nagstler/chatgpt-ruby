# lib/chatgpt/client.rb

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

    # Search-related methods
    def search(documents, query, params = {})
      engine = params[:engine] || 'ada'
      max_rerank = params[:max_rerank] || 200

      url = "#{@endpoint}/engines/#{engine}/search"
      data = {
        documents: documents,
        query: query,
        max_rerank: max_rerank
      }
      response = request_api(url, data)
      response['data']
    end

    # Classification-related methods
    def classify(text, params = {})
      model = params[:model] || 'text-davinci-002'

      url = "#{@endpoint}/classifications/#{model}"
      data = {
        model: model,
        input: text
      }
      response = request_api(url, data)
      response['data'][0]['label']
    end

    # Summary-related methods
    def generate_summaries(documents, params = {})
      model = params[:model] || 'text-davinci-002'
      max_tokens = params[:max_tokens] || 60
      temperature = params[:temperature] || 0.5
      top_p = params[:top_p] || 1.0
      frequency_penalty = params[:frequency_penalty] || 0.0
      presence_penalty = params[:presence_penalty] || 0.0

      url = "#{@endpoint}/engines/#{model}/generate"
      data = {
        prompt: '',
        max_tokens: max_tokens,
        temperature: temperature,
        top_p: top_p,
        frequency_penalty: frequency_penalty,
        presence_penalty: presence_penalty,
        documents: documents
      }
      response = request_api(url, data)
      response['choices'][0]['text']
    end

    # Answer-generation-related methods
    def generate_answers(prompt, documents, params = {})
      model = params[:model] || 'text-davinci-002'
      max_tokens = params[:max_tokens] || 5

      url = "#{@endpoint}/engines/#{model}/answers"
      data = {
        prompt: prompt,
        documents: documents,
        max_tokens: max_tokens
      }
      response = request_api(url, data)
      response['data'][0]['answer']
    end

    private

    # Helper method to make API requests
    def request_api(url, data)
      begin
        response = RestClient.post(url, data.to_json, headers)
        JSON.parse(response.body)
      rescue RestClient::ExceptionWithResponse => e
        error_msg = JSON.parse(e.response.body)['error']['message']
        raise RestClient::ExceptionWithResponse.new("#{e.message}: #{error_msg} (#{e.http_code})"), nil, e.backtrace
      end
    end
  end
end
