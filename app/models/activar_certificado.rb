class ActivarCertificado
  include ActiveModel::Model

  attr_accessor :certificado, :llave, :rfc, :password
  validates :certificado, :llave, :rfc, :password, presence: true
  validate :validar_extension

  def save
    valid?
  end

  def valid?
    super ? subir! : false
  end

  def subir!
    if subir_certificado.valid?
      enable_certificado_emisor!
      true
    else
      add_response_errors_fm_timbrado_cfdi
      false
    end
  end

  def errors_fm_timbrado_cfdi
    errors[:base].present? ? errors[:base].to_sentence : ""
  end

  private

  def add_response_errors_fm_timbrado_cfdi
    errors.add :base, parse_response_error(subir_certificado.error)
  end

  def subir_certificado
    @subir_certificado ||= FmTimbradoCfdi.subir_certificado(
      rfc, certificado.read, llave.read, password
    )
  end

  def parse_response_error error
    match = error.match(/<faultstring>(.*)<\/faultstring>/)
    force_encoding_errors(match[1].to_s) if match
  end

  def force_encoding_errors error
    error.force_encoding('utf-8').encode
  end

  def enable_certificado_emisor!
    Emisor.first.update_column(:con_certificado, true)
  end

  def validar_extension
    valida_extension(:llave, /\.key$/)
    valida_extension(:certificado, /\.cer$/)
  end

  def valida_extension attr, regex
    unless send(attr).present? && send(attr).original_filename =~ regex
      errors.add(attr, "La extensión del archivo es incorrecta")
    end
  end
end
