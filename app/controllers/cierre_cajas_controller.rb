class CierreCajasController < ApplicationController
  before_action :authenticate_usuario!
  before_action :set_cierre_caja, only: [:show, :edit, :update, :destroy, :cerrar]

  # GET /cierre_cajas
  # GET /cierre_cajas.json
  def index
    @cierre_cajas = policy_scope(CierreCaja)
      .order(created_at: :desc)
      .page(params[:page])
  end

  # GET /cierre_cajas/1
  # GET /cierre_cajas/1.json
  def show
    authorize @cierre_caja
    @arqueos = @cierre_caja.arqueos.page(params[:page])
  end

  # GET /cierre_cajas/1/edit
  def edit
    authorize @cierre_caja
  end

  # POST /cierre_cajas
  # POST /cierre_cajas.json
  def create
    @cierre_caja = CierreCaja.new(cierre_caja_params)
    authorize @cierre_caja

    respond_to do |format|
      if @cierre_caja.save
        format.html { redirect_to @cierre_caja, notice: 'Cierre caja se creó correctamente.' }
        format.json { render :show, status: :created, location: @cierre_caja }
      else
        format.html { render :new }
        format.json { render json: @cierre_caja.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cierre_cajas/1
  # PATCH/PUT /cierre_cajas/1.json
  def update
    authorize @cierre_caja
    respond_to do |format|
      if @cierre_caja.update(cierre_caja_params)
        format.html { redirect_to @cierre_caja, notice: 'Cierre caja was successfully updated.' }
        format.json { render :show, status: :ok, location: @cierre_caja }
      else
        format.html { render :edit }
        format.json { render json: @cierre_caja.errors, status: :unprocessable_entity }
      end
    end
  end

  def cerrar
    authorize @cierre_caja
    @cierre_caja.update_column(:abierta, false)
  end

  private
    def set_cierre_caja
      @cierre_caja = CierreCaja.includes(:arqueos).find(params[:id])
    end

    def cierre_caja_params
      params.require(:cierre_caja).permit(:monto_sistema, :monto_cajero, :observacion, :cajero_id)
    end
end
