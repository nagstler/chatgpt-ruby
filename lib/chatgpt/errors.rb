# lib/chatgpt/errors.rb
module ChatGPT
    class Error < StandardError; end
  
    class APIError < Error
      attr_reader :status_code, :error_type
  
      def initialize(message = nil, status_code = nil, error_type = nil)
        @status_code = status_code
        @error_type = error_type
        super(message)
      end
    end
  
    class AuthenticationError < APIError; end
    class RateLimitError < APIError; end
    class InvalidRequestError < APIError; end
    class TokenLimitError < APIError; end
end