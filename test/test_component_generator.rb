# frozen_string_literal: true

require "test_helper"

class TestComponentGenerator < Minitest::Test
  def test_that_it_generates_a_component_with_namespaces
    component = PhlexCustomElementGenerator::ComponentGenerator.new(
      class_name: "MyElement",
      tag_name: "my-element",
      namespaces: ["Foo", "Bar"]
    ).create

    assert_equal(component, File.read(fixture_path("component_with_namespaces.rb")))
  end

  def test_that_it_generates_a_component_with_no_namespaces
    component = PhlexCustomElementGenerator::ComponentGenerator.new(
      class_name: "MyElement",
      tag_name: "my-element",
    ).create

    assert_equal(component, File.read(fixture_path("component_no_namespaces.rb")))
  end
end
