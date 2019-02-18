class FacturasController < ApplicationController
  before_action :authenticate_usuario!

  def index
    @facturas = policy_scope(Factura)
  end

  def show
    @factura = Factura.find(params[:id]) 
  end
end
