class ArqueosController < ApplicationController
  before_action :authenticate_usuario!
  before_action :set_arqueo, only: [:show, :edit]

  # GET /arqueos
  # GET /arqueos.json
  def index
    @arqueos = current_usuario.arqueos.order(created_at: :desc)
  end

  # GET /arqueos/1
  # GET /arqueos/1.json
  def show
    @dinero = @arqueo.dinero
  end

  # GET /arqueos/new
  def new
    @arqueo = Arqueo.new dinero: Dinero.new
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
    @cierre_caja = current_cierre_caja
    @arqueo = Arqueo.new(arqueo_params)

    respond_to do |format|
      if @cierre_caja.arqueos << @arqueo
        update_comprobantes_sin_arqueo
        format.html { redirect_to @arqueo, notice: 'Arqueo was successfully created.' }
        format.json { render :show, status: :created, location: @arqueo }
      else
        current_cierre_caja
        format.html { render :new }
        format.json { render json: @arqueo.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def update_comprobantes_sin_arqueo
      @comprobantes = Comprobante.where(arqueo_id: nil).
        where(caja_id: current_usuario.caja.id).
        where(created_at: Date.current.beginning_of_day..Date.current.end_of_day)
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
          :veinte_pesos, :cincuenta_pesos, :cien_pesos,
          :doscientos_pesos, :quinientos_pesos, :mil_pesos,
          :dos_mil_pesos, :total
        ]
      )
    end
end
