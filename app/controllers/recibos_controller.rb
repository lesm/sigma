class RecibosController < ApplicationController
  before_action :set_recibo, only: [:show, :update, :destroy]

  # GET /recibos
  # GET /recibos.json
  def index
    @recibos = Recibo.all
  end

  # GET /recibos/1
  # GET /recibos/1.json
  def show
  end

  # POST /recibos
  # POST /recibos.json
  def create
    @recibo = Recibo.new(recibo_params)

    respond_to do |format|
      if @recibo.save
        format.html { redirect_to @recibo, notice: 'Recibo creado correctamente.' }
        format.json { render :show, status: :created, location: @recibo }
      else
        @cuenta_params = {
          contribuyente_id: recibo_params["contribuyente_id"],
          cuenta_ids: params["cuenta_ids"].first.split
        }
        format.html { render "recibo_steps/set_conceptos" }
        format.json { render json: @recibo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recibos/1
  # DELETE /recibos/1.json
  def destroy
    @recibo.destroy
    respond_to do |format|
      format.html { redirect_to recibos_url, notice: 'Recibo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recibo
      @recibo = Recibo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recibo_params
      params.require(:recibo).permit(
        :id, :serie, :folio, :moneda, :tipo_comprobante,
        :lugar_expedicion, :metodo_pago, :forma_pago, :subtotal,
        :total, :descuento, :motivo_descuento, :fecha_emision,
        :observaciones, :cajero_id, :contribuyente_id, :emisor_id,
        :timbrado_automatico, :caja_id,
        conceptos_attributes: [
          :id, :clave, :clave_unidad, :unidad,
          :cantidad, :descripcion, :valor_unitario, :importe, :cuenta_id,
          :_destroy,
          datos_concepto_attributes: [
            :id, :folio, :clave_catastral, :numero_cuenta, :ubicacion,
            :base_catastral, :impuesto_predial, :observaciones, :fecha,
            :serie, :placa, :estimacion, :nombre_obra, :localidad,
            :nombre_contratista, :fecha_refrendo, :cantidad_folios_cinco,
            :cantidad_folios_diez, :resposable, :mes_pago, :fecha_corte,
            :numero_contrato, :numero_medidor, :lectura_actual,
            :lectura_anterior, :consumo, :ruta, :lecturista, :type
          ]
        ]
      )
    end
end
