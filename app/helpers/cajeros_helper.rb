module CajerosHelper
  def estado_cajero cajero
    content_tag :span, class: "badge #{badge_class(cajero)}" do
      cajero.activo? ? "Activo" : "Inactivo"
    end
  end

  def para_registro?
    ["new", "create"].include? action_name
  end

  private

  def badge_class cajero
    cajero.activo? ? "badge-success" : "badge-danger"
  end
end
