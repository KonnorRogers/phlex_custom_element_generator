class ComponentGenerator
  attr_accessor :class_name, :tag_name, :namespaces, :component_code

  def initialize(class_name:, tag_name:, namespaces: [])
    @class_name = class_name
    @tag_name = tag_name
    @namespaces = namespaces

    @component_code = <<~RUBY
class <%= @class_name %> < Phlex::HTML
  register_element :<%= @tag_name %>

  def view_template
    <%= @tag_name %>
  end
end
RUBY
  end

  def create
    str = ""
    namespaces.each.with_index do |namespace, index|
      indent = "  " * index
      str += "#{indent}module #{namespace}\n"
      if index == namespaces.length - 1
        str += @component_code
        str += "\n"
      end
      str += indent + "end\n"
    end
    str
  end
end
