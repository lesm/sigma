class ActivarCertificadosController < ApplicationController
  before_action :authenticate_usuario!

  def new
    @activar_certificado = ActivarCertificado.new
    authorize @activar_certificado
  end

  def create
    @activar_certificado = ActivarCertificado.new(certificado_params)
    authorize @activar_certificado

    if @activar_certificado.save
      flash.notice = "Certificado activado correctamente."
      redirect_to root_path
    else
      flash.alert = "El certificado no es válido. #{@activar_certificado.errors_fm_timbrado_cfdi}".strip
      render :new
    end
  end

  def certificado_params
    params.require(:activar_certificado).permit(
      :certificado, :llave, :rfc, :password
    )
  end
end
