class AdeudosController < ApplicationController
  before_action :authenticate_usuario!
  before_action :set_adeudo, only: [:show, :edit, :update, :destroy]

  # GET /adeudos
  # GET /adeudos.json
  def index
    @adeudos = Adeudo.order(created_at: :desc).page(params[:page])
  end

  # GET /adeudos/1
  # GET /adeudos/1.json
  def show
  end

  # GET /adeudos/new
  def new
    @adeudo = Adeudo.new
  end

  # GET /adeudos/1/edit
  def edit
  end

  # POST /adeudos
  # POST /adeudos.json
  def create
    @adeudo = Adeudo.new(adeudo_params)

    respond_to do |format|
      if @adeudo.save
        format.html { redirect_to @adeudo, notice: 'Adeudo was successfully created.' }
        format.json { render :show, status: :created, location: @adeudo }
      else
        format.html { render :new }
        format.json { render json: @adeudo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /adeudos/1
  # PATCH/PUT /adeudos/1.json
  def update
    respond_to do |format|
      if @adeudo.update(adeudo_params)
        format.html { redirect_to @adeudo, notice: 'Adeudo was successfully updated.' }
        format.json { render :show, status: :ok, location: @adeudo }
      else
        format.html { render :edit }
        format.json { render json: @adeudo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /adeudos/1
  # DELETE /adeudos/1.json
  def destroy
    @adeudo.destroy
    respond_to do |format|
      format.html { redirect_to adeudos_url, notice: 'Adeudo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_adeudo
      @adeudo = Adeudo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def adeudo_params
      params.require(:adeudo).permit(:anticipo, :monto, :liquidado, :cajero_id, :arqueo_id)
    end
end
