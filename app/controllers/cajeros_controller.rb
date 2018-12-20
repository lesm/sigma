class CajerosController < ApplicationController
  before_action :authenticate_usuario!
  before_action :set_cajero, only: [:show, :edit, :update, :destroy]

  # GET /cajeros
  # GET /cajeros.json
  def index
    @cajeros = policy_scope(Cajero).page(params[:page])
  end

  # GET /cajeros/1
  # GET /cajeros/1.json
  def show
    authorize @cajero
  end

  # GET /cajeros/new
  def new
    @cajero = Cajero.new
    build_contribuyente
    authorize @cajero
  end

  # GET /cajeros/1/edit
  def edit
    authorize @cajero
  end

  # POST /cajeros
  # POST /cajeros.json
  def create
    @cajero = Cajero.new(cajero_params)
    authorize @cajero

    respond_to do |format|
      if @cajero.save
        format.html { redirect_to @cajero, notice: 'Cajero fue creado correctamente.' }
        format.json { render :show, status: :created, location: @cajero }
      else
        build_contribuyente
        format.html { render :new }
        format.json { render json: @cajero.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cajeros/1
  # PATCH/PUT /cajeros/1.json
  def update
    authorize @cajero
    respond_to do |format|
      if @cajero.update(override_cajero_params)
        format.html { redirect_to @cajero, notice: 'Cajero was successfully updated.' }
        format.json { render :show, status: :ok, location: @cajero }
      else
        format.html { render :edit }
        format.json { render json: @cajero.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cajero
      @cajero = Cajero.find(params[:id])
    end

    def override_cajero_params
      new_cajero_params = cajero_params
      if cajero_params[:password].blank?
        new_cajero_params.delete(:password)
      end
      new_cajero_params
    end

    def build_contribuyente
      @contribuyente = Contribuyente.new(direccion: Direccion.new)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cajero_params
      params.require(:cajero).permit(
        :id, :nombre, :username, :password, :activo, :contribuyente_id
      )
    end
end
