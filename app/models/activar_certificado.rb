class ActivarCertificado
  include ActiveModel::Model

  attr_accessor :certificado, :llave, :rfc, :password
  validates :certificado, :llave, :rfc, :password, presence: true
  validate :validar_extension

  def save
    valid?
  end

  private

  def validar_extension
    valida_extension(:llave, /\.key$/)
    valida_extension(:certificado, /\.cer$/)
  end

  def valida_extension attr, regex
    unless send(attr) && send(attr).original_filename =~ regex
      errors.add(attr, "La extensión del archivo es incorrecta")
    end
  end
end
