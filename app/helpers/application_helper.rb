module ApplicationHelper
  def line_img(line_name)
    (line_name.length > 1 || line_name == "H") ? "S" : line_name
  end
end
