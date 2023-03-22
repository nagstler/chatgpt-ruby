# frozen_string_literal: true

require_relative "lib/chatgpt/ruby/version"

Gem::Specification.new do |spec|
  spec.name = "chatgpt-ruby"
  spec.version = Chatgpt::Ruby::VERSION
  spec.authors = ["Nagendra Dhanakeerthi"]
  spec.email = ["nagendra.dhanakeerthi@gmail.com"]

  spec.summary     = 'A Ruby SDK for the OpenAI API'
  spec.description = 'This gem provides a Ruby SDK for interacting with the OpenAI API, including methods for generating text, completing prompts, and more.'
  spec.homepage = "https://github.com/nagstler/chatgpt-ruby.git"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  # spec.metadata["allowed_push_host"] = "Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/nagstler/chatgpt-ruby.git"
  spec.metadata["changelog_uri"] = "https://github.com/nagstler/chatgpt-ruby/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency 'rest-client'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
