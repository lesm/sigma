class AdministradoresController < ApplicationController
  before_action :set_administrador, only: [:show, :update]

  def new
    if Administrador.count.zero?
      @administrador = Administrador.new
    else
      redirect_to Administrador.first and return
    end
  end

  def edit
    #TODO change password in other way
    @administrador = Administrador.find(params[:id])
  end

  def show
  end

  def create
    @administrador = Administrador.new administrador_params
    respond_to do |format|
      if @administrador.save
        format.html {
          redirect_to @administrador, notice: "Administrador fue creado correctamente."
        }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @administrador.update(administrador_params)
        format.html {
          redirect_to @administrador, notice: "Administrador fue actualizado correctamente"
        }
      else
        format.html { render :edit }
      end
    end
  end

  private

  def set_administrador
    @administrador = Administrador.find(params[:id])
  end

  def administrador_params
    params.require(:administrador).permit(
      :nombre, :username, :password, :activo
    )
  end
end
