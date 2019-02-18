class FacturasController < ApplicationController
  before_action :authenticate_usuario!

  def index
    @facturas = policy_scope(Factura)
      .order(created_at: :desc)
      .page(params[:page])
  end

  def show
    @factura = Factura.find(params[:id]) 
  end
end
