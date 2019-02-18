class FacturasController < ApplicationController
  before_action :authenticate_usuario!

  def index
    @facturas = Factura.all  
  end

  def show
    @factura = Factura.find(params[:id]) 
  end
end
