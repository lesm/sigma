class FacturaGlobalesController < ApplicationController
  before_action :authenticate_usuario!

  def index
    @factura_globales = FacturaGlobal.all
  end

  def new
    @recibos = []
    if rango_fechas
      @recibos = Recibo.sin_factura_global.where(created_at: rango_fechas)
    end

    @factura_global_form = FacturaGlobalForm.new(
      fecha_inicial: fecha_inicial, fecha_final: fecha_final
    )
  end

  private

  def rango_fechas
    fecha_inicial.beginning_of_day..fecha_final.end_of_day
  end

  def fecha_inicial
    params[:factura_global_form] ? params[:factura_global_form][:fecha_inicial].to_date : Date.current
  end

  def fecha_final
    params[:factura_global_form] ? params[:factura_global_form][:fecha_final].to_date : Date.current
  end
end
