class ArqueosController < ApplicationController
  before_action :authenticate_usuario!
  before_action :set_arqueo, only: [:show]

  # GET /arqueos
  # GET /arqueos.json
  def index
    @arqueos = policy_scope(Arqueo).order(created_at: :desc)
  end

  # GET /arqueos/1
  # GET /arqueos/1.pdf
  def show
    authorize @arqueo
    @dinero = @arqueo.dinero
    respond_to do |format|
      format.html
      format.pdf { render pdf: nombre_pdf,
                    template: "pdfs/arqueo" }
    end
  end

  # GET /arqueos/new
  def new
    @arqueo = Arqueo.new monto_sistema: total_monto_sistema, dinero: Dinero.new
    authorize @arqueo
  end

  def current_cierre_caja
    cierre_caja_abierta ? cierre_caja_abierta : crea_cierre_caja
  end

  def cierre_caja_abierta
    @cierre_caja_abierta ||= current_usuario.cierre_cajas.find_by_abierta(true)
  end

  def crea_cierre_caja
    CierreCaja.create cajero: current_usuario
  end

  # POST /arqueos
  # POST /arqueos.json
  def create
    @arqueo = Arqueo.new(arqueo_params)
    authorize @arqueo
    @cierre_caja = current_cierre_caja

    respond_to do |format|
      if @cierre_caja.arqueos << @arqueo
        update_comprobantes_sin_arqueo
        format.html { redirect_to @arqueo, notice: 'Arqueo se creo correctamente.' }
        format.json { render :show, status: :created, location: @arqueo }
      else
        current_cierre_caja
        format.html { render :new }
        format.json { render json: @arqueo.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def total_monto_sistema
      Comprobante.total_monto_sistema current_usuario
    end

    def nombre_pdf
      "arqueo_#{@arqueo.id}_#{@arqueo.created_at.to_s(:number)}".upcase
    end

    def update_comprobantes_sin_arqueo
      @comprobantes = Comprobante.para_arqueo_actual current_usuario
      @comprobantes.update_all(arqueo_id: @arqueo.id)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_arqueo
      @arqueo = Arqueo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def arqueo_params
      params.require(:arqueo).permit(
        :monto_sistema, :monto_cajero, :observacion, :cierre_caja_id,
        dinero_attributes: [
          :diez_centavos, :veinte_centavos, :cincuenta_centavos,
          :un_peso, :dos_pesos, :cinco_pesos, :diez_pesos,
          :veinte_pesos, :veinte_m_pesos, :cincuenta_pesos, :cien_pesos,
          :doscientos_pesos, :quinientos_pesos, :mil_pesos,
          :dos_mil_pesos, :total
        ]
      )
    end
end
