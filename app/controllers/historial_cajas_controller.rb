class HistorialCajasController < ApplicationController
  skip_before_action :redirect_to_seleccionar_caja, only: [:new, :create]
  before_action :authenticate_usuario!
  before_action :set_caja, only: :create

  def index
    fechas = { inicial: params[:fecha_inicial], final: params[:fecha_final] }
    @historial_cajas = policy_scope(HistorialCaja).includes(:caja, :cajero)
      .period(fechas).order(created_at: :desc).page(params[:page])
  end

  def new
    @historial_caja = HistorialCaja.new
    authorize @historial_caja
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
    @caja = Caja.find_by_id(historial_caja_params[:caja_id])
  end

  def historial_caja_params
    params.require(:historial_caja).permit(
      :caja_id, :cajero_id
    )
  end
end
