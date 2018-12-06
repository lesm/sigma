class ReportesController < ApplicationController
  def new
    @reporte = ReporteForm.new(nombre: params[:nombre],
                               fecha_inicial: Date.current,
                               fecha_final: Date.current)
  end

  def cajeros
    @reporte = CajeroForm.new(reporte_params)
    if @reporte.valid?
      @cajero = Cajero.find(@reporte.cajero_id)
      @cierre_cajas = @cajero.cierre_cajas.where(created_at: @reporte.fecha_inicial..@reporte.fecha_final)

      @suma_montos_cajero = @cierre_cajas.map(&:monto_cajero).reduce(0,:+)
      @suma_montos_sistema = @cierre_cajas.map(&:monto_sistema).reduce(0,:+)
      @suma_montos_adeudo = @cierre_cajas.map(&:monto_adeudo).reduce(0,:+)
      @suma_montos_ingreso_por_clasificar = @cierre_cajas.map(&:monto_ingreso_por_clasificar).reduce(0,:+)

      render generar_pdf("cajero").merge!(options)
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

  def reporte_params
    params.require(:reporte_form).permit(
      :nombre, :cajero_id, :fecha_inicial, :fecha_final
    )
  end
end
