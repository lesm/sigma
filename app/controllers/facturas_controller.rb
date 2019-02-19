class FacturasController < ApplicationController
  before_action :authenticate_usuario!

  def index
    @facturas = policy_scope(Factura)
      .order(created_at: :desc)
      .page(params[:page])
  end

  def show
    @factura = Factura.find(params[:id])
    authorize @factura

    respond_to do |format|
      format.html
      format.pdf { send_file(@factura.pdf.path, filename: "#{@factura.uuid}.pdf", type: "application/pdf")}
      format.xml { send_file(@factura.xml.path, filename: "#{@factura.uuid}.xml", type: "application/xml")}
    end
  end
end
