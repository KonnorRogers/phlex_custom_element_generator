# frozen_string_literal: true

require_relative "phlex_custom_element_generator/version"
require_relative "phlex_custom_element_generator/cli.rb"
require_relative "phlex_custom_element_generator/component_generator.rb"
require_relative "phlex_custom_element_generator/manifest_reader.rb"

module PhlexCustomElementGenerator
  class Error < StandardError; end
  # Your code goes here...
end
