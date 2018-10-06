module RecibosHelper
  def color_name index
    return "color-2" if index.zero?
    index.odd? ? "color-1" : "color-2"
  end
end
