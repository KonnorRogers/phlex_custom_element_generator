class MyElement < Phlex::HTML
  register_element :my_element

  def initialize(
    **attributes
  )
    @attributes = attributes.with_defaults({
    })
  end

  def view_template(&)
    my_element(**@attributes, &)
  end
end
