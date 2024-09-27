class MyElement < Phlex::HTML
  register_element :my_element

  def view_template
    my_element
  end
end
