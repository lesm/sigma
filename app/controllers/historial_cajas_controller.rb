class HistorialCajasController < ApplicationController
  skip_before_action :redirect_to_seleccionar_caja
  before_action :set_caja, only: :create

  def new
    @historial_caja = HistorialCaja.new
    @cajas = Caja.where(disponible: true)
  end

  def create
    @historial_caja = HistorialCaja.new(historial_caja_params)

    if @historial_caja.save
      @caja.cerrar!(current_usuario.id)
      redirect_to dashboard_path, notice: "Caja asignada correctamente."
    else
      render :new
    end
  end

  private

  def set_caja
    @caja = Caja.find(historial_caja_params[:caja_id])
  end

  def historial_caja_params
    params.require(:historial_caja).permit(
      :caja_id, :cajero_id
    )
  end
end
