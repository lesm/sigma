module EmisoresHelper
  def no_exite_emisor?
    Emisor.count == 0
  end
end
