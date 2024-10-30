# Gemfile
source "https://rubygems.org"

# Specify your gem's dependencies in chatgpt-ruby.gemspec
gemspec

# Development dependencies
gem "rake", "~> 13.0"
gem "minitest", "~> 5.0"
gem "rubocop", "~> 1.21"

group :test do
  gem 'simplecov', require: false
  gem 'simplecov_json_formatter', require: false
  gem 'webmock'
end

# Platform specific gems
platforms :ruby, :mri, :mingw, :x64_mingw do
  gem 'rest-client'
end