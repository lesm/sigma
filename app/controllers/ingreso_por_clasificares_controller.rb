class IngresoPorClasificaresController < ApplicationController
  def index
    @ingresos = IngresoPorClasificar.includes(:cajero, :arqueo)
      .page(params[:page])
  end
end
