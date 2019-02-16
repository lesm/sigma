class RecibosController < ApplicationController
  before_action :authenticate_usuario!
  before_action :set_recibo, only: [:show, :update, :destroy]

  # GET /recibos
  # GET /recibos.json
  def index
    @recibos = policy_scope(Recibo)
      .order(created_at: :desc)
      .page(params[:page])
  end

  # GET /recibos/1
  # GET /recibos/1.json
  def show
    authorize @recibo
    respond_to do |format|
      format.html
      format.pdf { render generar_pdf }
    end
  end

  # POST /recibos
  # POST /recibos.json
  def create
    @recibo = Recibo.new(recibo_params)
    authorize @recibo

    respond_to do |format|
      if @recibo.save
        format.html { redirect_to @recibo, notice: 'Recibo fue creado correctamente.' }
        format.json { render :show, status: :created, location: @recibo }
      else
        @cuenta_params = {
          contribuyente_id: recibo_params["contribuyente_id"],
          cuenta_ids: params["cuenta_ids"].first.split
        }
        #TODO set total correctly after render to recibo_steps/set_conceptos
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
      format.html { redirect_to recibos_url, notice: 'Recibo fue eliminado correctamente.' }
      format.json { head :no_content }
    end
  end

  private

    def generar_pdf
      {
        pdf: nombre_pdf,
        page_size: "Letter",
        template: "pdfs/comprobantes/recibo.pdf.haml",
        viewport_size: "1280x1024",
        margin: { top: "65", bottom: "90" },
        header: { html: { template: "pdfs/comprobantes/header.pdf.haml" } },
        footer: { html: { template: "pdfs/comprobantes/footer.pdf.haml" } }
      }
    end

    def nombre_pdf
      "recibo_#{@recibo.id}_#{@recibo.created_at.to_s(:number)}".upcase
    end

    def set_recibo
      @recibo = Recibo.find(params[:id])
    end

    def recibo_params
      params.require(:recibo).permit(
        :id, :serie, :folio, :moneda, :tipo_comprobante,
        :lugar_expedicion, :metodo_pago, :forma_pago, :subtotal,
        :total, :descuento, :motivo_descuento, :fecha_emision, :uso_cfdi,
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
            :cantidad_folios_diez, :responsable, :mes_pago, :fecha_corte,
            :numero_contrato, :numero_medidor, :lectura_actual,
            :lectura_anterior, :consumo, :ruta, :lecturista, :type, years: []
          ]
        ]
      )
    end
end
