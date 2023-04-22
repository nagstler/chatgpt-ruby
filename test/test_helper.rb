# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "chatgpt/ruby"

require "minitest/autorun"

require 'simplecov'
require 'simplecov_json_formatter'

  # Add more helper methods to be used by all tests here...
  SimpleCov.formatter = SimpleCov::Formatter::JSONFormatter


