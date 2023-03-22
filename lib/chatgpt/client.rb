# lib/chatgpt_api.rb

require 'rest-client'
require 'json'

module ChatGPT
  class Client
    def initialize(api_key)
      @api_key = api_key
      @endpoint = 'https://api.openai.com/v1'
    end

    def completions(prompt, params = {})
      engine = params[:engine] || 'text-davinci-002'
      max_tokens = params[:max_tokens] || 16
      temperature = params[:temperature] || 0.5
      top_p = params[:top_p] || 1.0
      n = params[:n] || 1

      url = "#{@endpoint}/engines/#{engine}/completions"
      headers = {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{@api_key}"
      }
      data = {
        prompt: prompt,
        max_tokens: max_tokens,
        temperature: temperature,
        top_p: top_p,
        n: n
      }
      response = RestClient.post(url, data.to_json, headers)
      JSON.parse(response.body)
    end

    def search(documents, query, params = {})
      engine = params[:engine] || 'ada'
      max_rerank = params[:max_rerank] || 200

      url = "#{@endpoint}/engines/#{engine}/search"
      headers = {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{@api_key}"
      }
      data = {
        documents: documents,
        query: query,
        max_rerank: max_rerank
      }
      response = RestClient.post(url, data.to_json, headers)
      JSON.parse(response.body)['data']
    end

    def classify(text, params = {})
      model = params[:model] || 'text-davinci-002'

      url = "#{@endpoint}/classifications/#{model}"
      headers = {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{@api_key}"
      }
      data = {
        model: model,
        input: text
      }
      response = RestClient.post(url, data.to_json, headers)
      JSON.parse(response.body)['data'][0]['label']
    end

    def generate_summaries(documents, params = {})
      model = params[:model] || 'text-davinci-002'
      max_tokens = params[:max_tokens] || 60
      temperature = params[:temperature] || 0.5
      top_p = params[:top_p] || 1.0
      frequency_penalty = params[:frequency_penalty] || 0.0
      presence_penalty = params[:presence_penalty] || 0.0

      url = "#{@endpoint}/engines/#{model}/generate"
      headers = {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{@api_key}"
      }
      data = {
        prompt: '',
        max_tokens: max_tokens,
        temperature: temperature,
        top_p: top_p,
        frequency_penalty: frequency_penalty,
        presence_penalty: presence_penalty,
        documents: documents
      }
      response = RestClient.post(url, data.to_json, headers)
      JSON.parse(response.body)['choices'][0]['text']
    end

    def generate_answers(prompt, documents, params = {})
      model = params[:model] || 'text-davinci-002'
      max_tokens = params[:max_tokens] || 5

      url = "#{@endpoint}/engines/#{model}/answers"
      headers = {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{@api_key}"
      }
      data = {
        prompt: prompt,
        documents: documents,
        max_tokens: max_tokens
      }
      response = RestClient.post(url, data.to_json, headers)
      JSON.parse(response.body)['data'][0]['answer']
    end
  end
end
