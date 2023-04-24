# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "chatgpt/ruby"

require "minitest/autorun"

require 'simplecov'
require 'simplecov-json'

SimpleCov.formatter = SimpleCov::Formatter::JSONFormatter
SimpleCov.start


