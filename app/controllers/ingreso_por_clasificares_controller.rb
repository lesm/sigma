class IngresoPorClasificaresController < ApplicationController
  before_action :authenticate_usuario!

  def index
    @ingresos = policy_scope(IngresoPorClasificar).includes(:cajero, :arqueo)
      .order(created_at: :desc)
      .page(params[:page])
  end
end
