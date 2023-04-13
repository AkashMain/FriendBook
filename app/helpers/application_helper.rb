module ApplicationHelper
  def render_flash_messages
    flash.map do |key, value|
      content_tag(:div, value, class: "alert alert-#{key}")
    end.join.html_safe
  end
end