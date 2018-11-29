class ContribuyentesController < ApplicationController
  before_action :authenticate_usuario!
  before_action :set_contribuyente, only: [:show, :edit, :update, :destroy]

  # GET /contribuyentes
  # GET /contribuyentes.json
  def index
    @contribuyentes = policy_scope(Contribuyente).search(params[:search]).page(params[:page])
  end

  # GET /contribuyentes/1
  # GET /contribuyentes/1.json
  def show
    authorize @contribuyente
  end

  # GET /contribuyentes/new
  def new
    @contribuyente = Contribuyente.new direccion: Direccion.new
    authorize @contribuyente
  end

  # GET /contribuyentes/1/edit
  def edit
    authorize @contribuyente
  end

  # POST /contribuyentes
  # POST /contribuyentes.json
  def create
    @contribuyente = Contribuyente.new(contribuyente_params)
    authorize @contribuyente

    respond_to do |format|
      if @contribuyente.save
        format.html { redirect_to @contribuyente, notice: 'Contribuyente was successfully created.' }
        format.json { render :show, status: :created, location: @contribuyente }
        format.js
      else
        format.html { render :new }
        format.json { render json: @contribuyente.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /contribuyentes/1
  # PATCH/PUT /contribuyentes/1.json
  def update
    authorize @contribuyente
    respond_to do |format|
      if @contribuyente.update(contribuyente_params)
        format.html { redirect_to @contribuyente, notice: 'Contribuyente was successfully updated.' }
        format.json { render :show, status: :ok, location: @contribuyente }
      else
        format.html { render :edit }
        format.json { render json: @contribuyente.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contribuyente
      @contribuyente = Contribuyente.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contribuyente_params
      params.require(:contribuyente).permit(
        :nombre_o_razon_social, :primer_apellido, :segundo_apellido, :persona_fisica, :email, :rfc,
        direccion_attributes: [:id, :calle, :numero, :colonia, :codigo_postal, :localidad,
                               :municipio, :estado, :pais]
      )
    end
end
