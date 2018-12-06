class ReportesController < ApplicationController
  def new
    nombre = params[:nombre] || "cajero"
    @reporte = ReporteForm.new(nombre: nombre,
                               fecha_inicial: Date.current,
                               fecha_final: Date.current)
  end

  def cajeros
    @reporte = CajeroForm.new(reporte_params)
    if @reporte.valid?
      @cajero = Cajero.find(@reporte.cajero_id)
      @cierre_cajas = @cajero.cierre_cajas.where(created_at: range_of_dates)

      @suma_montos_cajero = @cierre_cajas.map(&:monto_cajero).reduce(0,:+)
      @suma_montos_sistema = @cierre_cajas.map(&:monto_sistema).reduce(0,:+)
      @suma_montos_adeudo = @cierre_cajas.map(&:monto_adeudo).reduce(0,:+)
      @suma_montos_ingreso_por_clasificar = @cierre_cajas.map(&:monto_ingreso_por_clasificar).reduce(0,:+)
      render generar_pdf("cajero").merge!(options)
    else
      render :new
    end
  end

  def cuentas
    @reporte = ConceptoForm.new(reporte_params)
    if @reporte.valid?
      @conceptos = Concepto.includes(:comprobante)
        .where(comprobantes: {created_at: range_of_dates})
        .where(cuenta_id: @reporte.cuenta_id)
      @cuenta = Cuenta.find(@reporte.cuenta_id)
      @suma_importe_conceptos = @conceptos.map(&:importe).reduce(0,:+)
      render generar_pdf("cuenta").merge!(options)
    else
      render :new
    end
  end

  private

  def nombre_pdf
    "#{@cajero}_#{Date.current.to_s(:number)}".upcase
  end

  def options
    { orientation: "Landscape", disposition: "attachment" }
  end

  def range_of_dates
    fecha_inicial = @reporte.fecha_inicial.to_date.beginning_of_day
    fecha_final   = @reporte.fecha_final.to_date.end_of_day
    fecha_inicial..fecha_final
  end

  def reporte_params
    params.require(:reporte_form).permit(
      :nombre, :cajero_id, :fecha_inicial, :fecha_final,
      :cuenta_id
    )
  end
end
