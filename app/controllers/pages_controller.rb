class PagesController < ApplicationController
  layout "pages"

  def index
    if usuario_signed_in? and current_usuario.cajero?
      redirect_to new_historial_caja_path and return
    end
    redirect_to dashboard_index_path if usuario_signed_in?
  end
end
