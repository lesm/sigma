class FacturaGlobalesController < ApplicationController
  before_action :authenticate_usuario!

  def index
    @factura_globales = FacturaGlobal.all
  end

  def new
    @recibos = []
    conceptos_de_recibos_sin_factura_global if rango_fechas

    @factura_global_form = FacturaGlobalForm.new(
      fecha_inicial: fecha_inicial, fecha_final: fecha_final
    )
  end

  private

  def conceptos_de_recibos_sin_factura_global
    @conceptos = Concepto.where(comprobante_id: recibos_ids).page(params[:page])

    @suma_cantidad       = @conceptos.map(&:cantidad).reduce(0,:+)
    @suma_valor_unitario = @conceptos.map(&:valor_unitario).reduce(0,:+)
    @suma_importe        = @conceptos.map(&:importe).reduce(0,:+)
  end

  def recibos_ids
    Recibo.sin_factura_global.where(created_at: rango_fechas).ids
  end

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
