# chatgpt_client.rb
require 'httparty'
require 'json'

module ChatGPTRuby
  class Client
    include HTTParty
    base_uri 'https://api.openai.com/v1'

    def initialize(api_key)
      @api_key = api_key
      @headers = {
        'Authorization' => "Bearer #{@api_key}",
        'Content-Type' => 'application/json'
      }
    end

    # Methods to interact with the API
    def generate(prompt, options = {})
      body = {
        'prompt' => prompt,
        'max_tokens' => options.fetch(:max_tokens, 100),
        'n' => options.fetch(:n, 1),
        'stop' => options.fetch(:stop, nil),
        'temperature' => options.fetch(:temperature, 1.0),
        'top_p' => options.fetch(:top_p, 1.0),
        'frequency_penalty' => options.fetch(:frequency_penalty, 0.0),
        'presence_penalty' => options.fetch(:presence_penalty, 0.0),
      }.to_json

      response = self.class.post('/davinci-codex/completions', headers: @headers, body: body)
      handle_response(response)
    end

    private

    def handle_response(response)
      if response.code == 200
        JSON.parse(response.body)
      else
        raise "Error: #{response.code} - #{response.message}"
      end
    end
  end
end
