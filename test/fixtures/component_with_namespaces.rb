module Foo
  module Bar
    class MyElement < Phlex::HTML
      register_element :my_element

      def initialize(**attributes)
        @attributes = attributes
      end

      def view_template(&)
        my_element(**@attributes, &)
      end
    end
  end
end
