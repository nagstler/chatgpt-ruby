# frozen_string_literal: true

# test/chatgpt/test_helper.rb
module TestHelper
  def stub_openai_request
    stub_request(:post, /api.openai.com/)
      .to_return(
        status: 200,
        body: {
          choices: [
            {
              text: "Sample response",
              index: 0,
              logprobs: nil,
              finish_reason: "length"
            }
          ],
          usage: {
            prompt_tokens: 5,
            completion_tokens: 7,
            total_tokens: 12
          }
        }.to_json,
        headers: { "Content-Type" => "application/json" }
      )
  end
end
