module RecibosHelper
  def color_name index
    return "color-2" if index.zero?
    index.odd? ? "color-1" : "color-2"
  end

  def find_contribuyente id
    return [] if id.nil?
    Contribuyente.where(id: id)
  end
end
