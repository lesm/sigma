class CajerosController < ApplicationController
  before_action :set_cajero, only: [:show, :edit, :update, :destroy]

  # GET /cajeros
  # GET /cajeros.json
  def index
    @cajeros = Cajero.all
  end

  # GET /cajeros/1
  # GET /cajeros/1.json
  def show
  end

  # GET /cajeros/new
  def new
    atributos = {
      contribuyente: Contribuyente.new(direccion: Direccion.new)
    }
    @cajero = Cajero.new atributos
  end

  # GET /cajeros/1/edit
  def edit
  end

  # POST /cajeros
  # POST /cajeros.json
  def create
    @cajero = Cajero.new(cajero_params)

    respond_to do |format|
      if @cajero.save
        format.html { redirect_to @cajero, notice: 'Cajero was successfully created.' }
        format.json { render :show, status: :created, location: @cajero }
      else
        format.html { render :new }
        format.json { render json: @cajero.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cajeros/1
  # PATCH/PUT /cajeros/1.json
  def update
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

  # DELETE /cajeros/1
  # DELETE /cajeros/1.json
  def destroy
    @cajero.destroy
    respond_to do |format|
      format.html { redirect_to cajeros_url, notice: 'Cajero was successfully destroyed.' }
      format.json { head :no_content }
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def cajero_params
      params.require(:cajero).permit(
        :id, :nombre, :username, :password, :activo, :rol, :email,
        contribuyente_attributes: [
          :id, :nombre_o_razon_social, :primer_apellido, :segundo_apellido,
          :persona_fisica, :email, :rfc,
          direccion_attributes: [
            :id, :calle, :numero, :colonia, :codigo_postal, :localidad,
            :municipio, :estado, :pais
          ],
          conceptos_attributes: [:id, :cuenta_id, :_destroy]
        ]

      )
    end
end
