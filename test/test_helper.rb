# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "phlex_custom_element_generator"

def fixture_path(*strings)
  File.join(
    File.expand_path(__dir__),
    "fixtures", *strings
  )
end

require "minitest/autorun"
