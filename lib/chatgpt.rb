# lib/chatgpt.rb
# frozen_string_literal: true

require_relative "chatgpt/version"
require_relative "chatgpt/errors"
require_relative "chatgpt/configuration"
require_relative "chatgpt/client"

module ChatGPT
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def reset_configuration!
      @configuration = Configuration.new
    end
  end
end
