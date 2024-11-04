# chatgpt-ruby.gemspec
# frozen_string_literal: true

require_relative 'lib/chatgpt/version'

Gem::Specification.new do |spec|
  spec.name = 'chatgpt-ruby'
  spec.version = ChatGPT::VERSION
  spec.authors = ['Nagendra Dhanakeerthi']
  spec.email = ['nagendra.dhanakeerthi@gmail.com']

  spec.summary = "Ruby client for OpenAI's ChatGPT API"
  spec.description = "A Ruby SDK for OpenAI's ChatGPT API"
  spec.homepage = 'https://github.com/nagstler/chatgpt-ruby'
  spec.license = 'MIT'

  spec.platform = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 3.0.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/nagstler/chatgpt-ruby'
  spec.metadata['changelog_uri'] = 'https://github.com/nagstler/chatgpt-ruby/blob/main/CHANGELOG.md'

  spec.files = Dir.glob('{lib,exe}/**/*') + %w[README.md LICENSE.txt]
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rest-client', '~> 2.1'

  spec.add_development_dependency 'brakeman', '~> 6.2'
  spec.add_development_dependency 'bundler-audit', '~> 0.9'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rubocop', '~> 1.21'
  spec.add_development_dependency 'simplecov', '~> 0.21'
  spec.add_development_dependency 'simplecov_json_formatter', '~> 0.1'
  spec.add_development_dependency 'webmock', '~> 3.18'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
