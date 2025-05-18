# frozen_string_literal: true

# lib/chatgpt/client.rb
require 'rest-client'
require 'json'

module ChatGPT
  class Client
    def initialize(api_key = nil)
      @api_key = api_key || ChatGPT.configuration.api_key
      @endpoint = 'https://api.openai.com/v1'
      @config = ChatGPT.configuration
    end

    def completions(prompt, params = {})
      engine = params[:engine] || @config.default_engine
      url = "#{@endpoint}/engines/#{engine}/completions"

      data = @config.default_parameters.merge(
        prompt: prompt,
        max_tokens: params[:max_tokens],
        temperature: params[:temperature],
        top_p: params[:top_p],
        n: params[:n]
      ).compact

      request_api(url, data)
    end

    def chat(messages, params = {})
      url = "#{@endpoint}/chat/completions"

      data = @config.default_parameters.merge(
        model: params[:model] || @config.default_engine, # Use configured default_engine
        messages: messages,
        temperature: params[:temperature],
        top_p: params[:top_p],
        n: params[:n],
        stream: params[:stream] || false
      ).compact

      request_api(url, data)
    end

    def chat_stream(messages, params = {}, &block)
      raise ArgumentError, 'Block is required for streaming' unless block_given?

      url = "#{@endpoint}/chat/completions"
      data = @config.default_parameters.merge(
        model: params[:model] || @config.default_engine, # Use configured default_engine
        messages: messages,
        stream: true
      ).compact

      request_streaming(url, data, &block)
    end

    private

    def request_api(url, data)
      response = RestClient::Request.execute(
        method: :post,
        url: url,
        payload: data.to_json,
        headers: {
          'Authorization' => "Bearer #{@api_key}",
          'Content-Type' => 'application/json'
        },
        timeout: @config.request_timeout
      )
      JSON.parse(response.body)
    rescue RestClient::ExceptionWithResponse => e
      handle_error(e)
    end

    def handle_error(error)
      error_response = JSON.parse(error.response.body)
      error_message = error_response['error']['message']
      status_code = error.response.code

      case status_code
      when 401
        raise ChatGPT::AuthenticationError.new(error_message, status_code)
      when 429
        raise ChatGPT::RateLimitError.new(error_message, status_code)
      when 400
        raise ChatGPT::InvalidRequestError.new(error_message, status_code)
      else
        raise ChatGPT::APIError.new(error_message, status_code)
      end
    end

    def request_options(url, data)
      { headers: {
          'Authorization' => "Bearer #{@api_key}",
          'Content-Type' => 'application/json'
        },
        method: :post,
        payload: data.to_json,
        stream_to_buffer: true,
        timeout: @config.request_timeout,
        url: url }
    end

    def request_streaming(url, data)
      RestClient::Request.execute(request_options(url, data)) do |chunk, _x, _z|
        chunk.split("\n").filter { |c| c.start_with?('data:') }.each do |line|
          data = line.sub(/^data: /, '')
          next if data.strip == '[DONE]'

          begin
            parsed = JSON.parse(data)
            yield parsed if block_given?
          rescue JSON::ParserError
            next
          end
        end
      end
    rescue RestClient::ExceptionWithResponse => e
      handle_error(e)
    end
  end
end
