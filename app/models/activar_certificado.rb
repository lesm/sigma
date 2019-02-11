class ActivarCertificado
  include ActiveModel::Model

  attr_accessor :certificado, :llave, :rfc, :password
  validates :certificado, :llave, :rfc, :password, presence: true

  def save
    valid?
  end
end
