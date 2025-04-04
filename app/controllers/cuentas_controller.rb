class CuentasController < ApplicationController
  before_action :authenticate_usuario!
  before_action :set_cuenta, only: [:show, :edit, :update, :destroy]

  # GET /cuentas
  # GET /cuentas.json
  def index
    @cuentas = policy_scope(Cuenta).search(params[:search]).page(params[:page])
  end

  # GET /cuentas/1
  # GET /cuentas/1.json
  def show
    authorize @cuenta
  end

  # GET /cuentas/new
  def new
    @cuenta = Cuenta.new
  end

  # GET /cuentas/1/edit
  def edit
    authorize @cuenta
  end

  # POST /cuentas
  # POST /cuentas.json
  def create
    @cuenta = Cuenta.new(cuenta_params)
    authorize @cuenta

    respond_to do |format|
      if @cuenta.save
        format.html { redirect_to @cuenta, notice: 'Cuenta fue creada correctamente.' }
        format.json { render :show, status: :created, location: @cuenta }
      else
        format.html { render :new }
        format.json { render json: @cuenta.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cuentas/1
  # PATCH/PUT /cuentas/1.json
  def update
    authorize @cuenta
    respond_to do |format|
      if @cuenta.update(cuenta_params)
        format.html { redirect_to @cuenta, notice: 'Cuenta fue actualizada correctamente.' }
        format.json { render :show, status: :ok, location: @cuenta }
      else
        format.html { render :edit }
        format.json { render json: @cuenta.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cuentas/1
  # DELETE /cuentas/1.json
  def destroy
    @cuenta.destroy
    respond_to do |format|
      format.html { redirect_to cuentas_url, notice: 'Cuenta fue eliminada correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    def set_cuenta
      @cuenta = Cuenta.find(params[:id])
    end

    def cuenta_params
      params.require(:cuenta).permit(
        :id, :codigo, :formato, :descripcion, :importe,
        :clave_producto, :clave_unidad
      )
    end
end
