module AdeudosHelper
  def liquidado adeudo
    adeudo.liquidado? ? "Pagado" : "Pendiente"
  end

  def referer_url_arqueo
    (request.referer =~ /arqueos/) ? request.referer : adeudos_path
  end
end
