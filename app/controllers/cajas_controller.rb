class CajasController < ApplicationController
  before_action :authenticate_usuario!
  before_action :set_caja, only: [:show, :edit, :update, :destroy]

  # GET /cajas
  # GET /cajas.json
  def index
    @cajas = policy_scope(Caja).page(params[:page])
  end

  # GET /cajas/1
  # GET /cajas/1.json
  def show
    authorize @caja
  end

  # GET /cajas/new
  def new
    @caja = Caja.new
    authorize @caja
  end

  # GET /cajas/1/edit
  def edit
    authorize @caja
  end

  # POST /cajas
  # POST /cajas.json
  def create
    @caja = Caja.new(caja_params)
    authorize @caja

    respond_to do |format|
      if @caja.save
        format.html { redirect_to @caja, notice: 'Caja fue creada correctamente.' }
        format.json { render :show, status: :created, location: @caja }
      else
        format.html { render :new }
        format.json { render json: @caja.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cajas/1
  # PATCH/PUT /cajas/1.json
  def update
    authorize @caja
    respond_to do |format|
      if @caja.update(caja_params)
        format.html { redirect_to @caja, notice: 'Caja fue actualizada correctamente.' }
        format.json { render :show, status: :ok, location: @caja }
      else
        format.html { render :edit }
        format.json { render json: @caja.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_caja
      @caja = Caja.find(params[:id])
    end

    def caja_params
      params.require(:caja).permit(:nombre, :numero, :descripcion, :disponible)
    end
end
