# require 'minitest/autorun'
# require 'chatgpt/client'

# class ChatGPTClientTest < Minitest::Test
#   def setup
#     @client = ChatGPT::Client.new('YOUR_API_KEY')
#   end

#   def test_completions
#     response = @client.completions('Hello, I am a', { max_tokens: 5 })
#     assert response.key?('choices')
#     assert_equal 1, response['choices'].size
#     assert response['choices'][0].key?('text')
#   end

#   # def test_search
#   #   documents = [
#   #     { text: 'This is the first document', title: 'Document 1' },
#   #     { text: 'This is the second document', title: 'Document 2' },
#   #     { text: 'This is the third document', title: 'Document 3' }
#   #   ]
#   #   response = @client.search(documents, 'second document')
#   #   assert_equal 1, response.size
#   #   assert_equal 'Document 2', response[0]['document']['title']
#   # end

#   # def test_classify
#   #   label = @client.classify('This is a test sentence')
#   #   assert label.is_a?(String)
#   #   refute label.empty?
#   # end

#   # def test_generate_summaries
#   #   documents = [
#   #     { text: 'This is the first document', title: 'Document 1' },
#   #     { text: 'This is the second document', title: 'Document 2' },
#   #     { text: 'This is the third document', title: 'Document 3' }
#   #   ]
#   #   summary = @client.generate_summaries(documents, { max_tokens: 10 })
#   #   assert summary.is_a?(String)
#   #   refute summary.empty?
#   # end

#   # def test_generate_answers
#   #   prompt = 'What is the capital of France?'
#   #   documents = ['Paris is the capital of France.']
#   #   answer = @client.generate_answers(prompt, documents, { max_tokens: 5 })
#   #   assert answer.is_a?(String)
#   #   refute answer.empty?
#   # end
# end
