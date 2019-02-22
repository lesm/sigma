class FacturaGlobalesController < ApplicationController
  before_action :authenticate_usuario!

  def index
    @factura_globales = policy_scope(FacturaGlobal)
      .order(created_at: :desc)
      .page(params[:page])
  end

  def show
    @factura_global = FacturaGlobal
      .includes(conceptos: [:cuenta, :datos_concepto])
      .find(params[:id])

    authorize @factura_global
  end

  def fechas
    @factura_global = FacturaGlobal.new
    authorize @factura_global
  end

  def new
    inicializar_variables
    @factura_global = FacturaGlobal.new(
      fecha_inicio: fecha_inicio, fecha_fin: fecha_fin,
      subtotal: @suma_importe, total: @suma_importe
    )
    authorize @factura_global
  end

  def create
    @factura_global = FacturaGlobal.new(factura_global_params)
    authorize @factura_global

    @factura_global.timbrado_automatico = true
    @factura_global.conceptos << conceptos_deep_clone

    if @factura_global.save
      asignar_factura_global
      redirect_to @factura_global, notice: "Factura global fue creada correctamente."
    else
      render :new
    end
  end

  private

  def asignar_factura_global
    Recibo.where(id: recibos_ids).update_all(factura_global_id: @factura_global.id)
  end

  def conceptos
    @conceptos ||= Concepto.where(comprobante_id: recibos_ids)
  end

  def inicializar_variables
    @suma_cantidad       = conceptos.sum(:cantidad)
    @suma_valor_unitario = conceptos.sum(:valor_unitario)
    @suma_importe        = conceptos.sum(:importe)
    @conceptos           = conceptos.page(params[:page])
  end

  def recibos_ids
    @recibos_ids ||= Recibo.sin_factura_global.where(created_at: rango_fechas).ids
  end

  def rango_fechas
    fecha_inicio.beginning_of_day..fecha_fin.end_of_day
  end

  def fecha_inicio
    factura_global_params[:fecha_inicio].to_date || Date.current
  end

  def fecha_fin
    factura_global_params[:fecha_fin].to_date || Date.current
  end

  def factura_global_params
    params.require(:factura_global).permit(
      :id, :serie, :folio, :moneda, :tipo_comprobante,
      :lugar_expedicion, :metodo_pago, :forma_pago, :subtotal,
      :total, :descuento, :motivo_descuento, :fecha_emision,
      :observaciones, :cajero_id, :contribuyente_id, :emisor_id,
      :timbrado_automatico, :caja_id, :uso_cfdi, :fecha_inicio, :fecha_fin
    )
  end

  def conceptos_deep_clone
    conceptos.map(&:duplicar)
  end
end
