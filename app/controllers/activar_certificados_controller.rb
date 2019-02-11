class ActivarCertificadosController < ApplicationController
  def new
  end

  def create
    @certificado = ActivarCertificado.new(certificado_params)
    if @certificado.save
      flash.notice = "Certificado activado correctamente."
      redirect_to root_path
    else
      flash.alert = "El certificado no válido."
      render :new
    end
  end

  def certificado_params
    params.require(:activar_certificado).permit(
      :certificado, :llave, :rfc, :password
    )
  end
end
