class ContribuyentesController < ApplicationController
  before_action :authenticate_usuario!
  before_action :set_contribuyente, only: [:show, :edit, :update, :destroy, :asignar_cuentas]

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
    cuentas_por_asignar
  end

  # POST /contribuyentes
  # POST /contribuyentes.json
  def create
    @contribuyente = Contribuyente.new(contribuyente_params)
    authorize @contribuyente

    respond_to do |format|
      if @contribuyente.save
        update_cuentas
        format.html { redirect_to @contribuyente, notice: 'Contribuyente fue creado correctamente.' }
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
        update_cuentas
        format.html { redirect_to @contribuyente, notice: 'Contribuyente fue actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @contribuyente }
      else
        format.html { render :edit }
        format.json { render json: @contribuyente.errors, status: :unprocessable_entity }
      end
    end
  end

  def asignar_cuentas
    #TODO add the newest cuenta to cuentas_seleccionadas
    @cuentas_seleccionadas = cuentas_seleccionadas
    update_cuentas
    load_cuentas_contribuyente
  end

  private
    def cuentas_seleccionadas
      cuentas = params[:cuentas_seleccionadas]
      cuentas.present? ? cuentas.first.split(",") : []
    end

    def set_contribuyente
      @contribuyente = Contribuyente.find(params[:id])
    end

    def update_cuentas
      @cuentas = Cuenta.where(id: set_cuenta_ids)
      @contribuyente.cuentas << @cuentas
    end

    def set_cuenta_ids
      params[:contribuyente][:cuenta_ids] || contribuyente_params[:concepto_ids]
    end

    def contribuyente_params
      params.require(:contribuyente).permit(
        :nombre_o_razon_social, :primer_apellido, :segundo_apellido, :persona_fisica,
        :email, :rfc, concepto_ids: [],
        direccion_attributes: [:id, :calle, :numero, :colonia, :codigo_postal, :localidad,
                               :municipio, :estado, :pais]
      )
    end
end
