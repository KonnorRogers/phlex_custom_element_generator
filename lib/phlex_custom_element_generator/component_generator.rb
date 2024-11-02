module PhlexCustomElementGenerator
  class ComponentGenerator
    attr_accessor :class_name, :tag_name, :namespaces, :component_code, :attributes

    def initialize(class_name:, tag_name:, namespaces: [], attributes: [])
      @class_name = class_name
      @tag_name = tag_name.gsub(/-/, "_")
      @namespaces = namespaces
      @attributes = attributes

      @component_code = <<~RUBY
class #{@class_name} < Phlex::HTML
  register_element :#{@tag_name}

  def initialize(
    #{attributes_to_kwargs}
  )
    @attributes = attributes.with_defaults({#{attribute_hash.to_s.empty? ? "" : "\n    " + attribute_hash}
    })
  end

  def view_template(&)
    #{@tag_name}(**@attributes, &)
  end
end
RUBY
    end


    def attributes_to_kwargs
      @attributes.length > 0 ?
        @attributes.map { |attr| "#{attr[:attr_name]}: #{attr[:default_value] || "nil"}" }.join(",\n    ") + ",\n    **attributes"
        : "**attributes"
    end

    def attribute_hash
      @attributes.length > 0 ?
        @attributes.map { |attr| "#{attr[:attr_name]}: #{attr[:attr_name]}" }.join(",\n      ")
        : ""
    end

    def create
      str = ""

      if namespaces.length <= 0
        str += @component_code
        return str
      end

      namespaces.each.with_index do |namespace, index|
        indent = "  " * index
        str += "#{indent}module #{namespace}\n"
        if index == namespaces.length - 1
          indent = indent + "  "
          str += indent + @component_code
            .split(/\n/)
            .join("\n#{indent}") # Add indentations
            .split(/\n/)
            .map(&:rstrip) # Remove extra spaces in lines that are newlines only.
            .join("\n")
            .chomp
          str += "\n"
        end
      end

      namespaces.each.with_index do |namespace, index|
        indent = "  " * (namespaces.length - 1 - index)
        str += "#{indent}end\n"
      end
      str
    end
  end
end
