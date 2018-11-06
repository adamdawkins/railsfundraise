module ApplicationHelper
  def form_group(&block)
    content_tag(:div, capture(&block), class: "form-group mb-4")
  end
end
