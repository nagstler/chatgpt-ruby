# lib/chatgpt/configuration.rb
module ChatGPT
  class Configuration
    attr_accessor :api_key, :api_version, :default_engine,
                  :request_timeout, :max_retries, :default_parameters

    def initialize
      @api_version = 'v1'
      @default_engine = 'text-davinci-002'
      @request_timeout = 30
      @max_retries = 3
      @default_parameters = {
        max_tokens: 16,
        temperature: 0.5,
        top_p: 1.0,
        n: 1
      }
    end
  end
end