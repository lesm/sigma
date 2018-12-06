module EmisoresHelper
  def no_exite_emisor?
    Emisor.count == 0
  end

  def texto_submit
    if action_name == "edit"
      "Actualizar Municipio"
    elsif action_name == "new"
      "Crear Municipio"
    end
  end

  def current_emisor
    Emisor.first
  end
end
