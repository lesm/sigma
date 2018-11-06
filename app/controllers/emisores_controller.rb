class EmisoresController < ApplicationController
  before_action :set_emisor, only: [:show, :edit, :update, :destroy]

  # GET /emisores
  # GET /emisores.json
  def index
    @emisores = Emisor.all
  end

  # GET /emisores/1
  # GET /emisores/1.json
  def show
  end

  # GET /emisores/new
  def new
    @emisor = Emisor.new direccion: Direccion.new
  end

  # GET /emisores/1/edit
  def edit
  end

  # POST /emisores
  # POST /emisores.json
  def create
    @emisor = Emisor.new(emisor_params)

    respond_to do |format|
      if @emisor.save
        format.html { redirect_to @emisor, notice: 'Emisor was successfully created.' }
        format.json { render :show, status: :created, location: @emisor }
      else
        format.html { render :new }
        format.json { render json: @emisor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /emisores/1
  # PATCH/PUT /emisores/1.json
  def update
    respond_to do |format|
      if @emisor.update(emisor_params)
        format.html { redirect_to @emisor, notice: 'Emisor was successfully updated.' }
        format.json { render :show, status: :ok, location: @emisor }
      else
        format.html { render :edit }
        format.json { render json: @emisor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emisores/1
  # DELETE /emisores/1.json
  def destroy
    @emisor.destroy
    respond_to do |format|
      format.html { redirect_to emisores_url, notice: 'Emisor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_emisor
      @emisor = Emisor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def emisor_params
      params.require(:emisor).permit(
        :nombre, :rfc, :logotipo, :regimen_fiscal,
        :registro_patronal, :eslogan, :escudo,
        :numero_municipio,
        direccion_attributes: [:id, :calle, :numero, :colonia, :codigo_postal, :localidad,
                               :municipio, :estado, :pais]
      )
    end
end
