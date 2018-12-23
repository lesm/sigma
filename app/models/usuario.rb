class Usuario < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  enum rol: {
    sin_rol: 0, cajero: 1, reporte: 2, admin: 3, super_user: 4
  }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

  validates :nombre, :username, presence: true
  validates :username, uniqueness: { case_sensitive: false }

  def email_required?
    false
  end

  def active_for_authentication?
    super && activo?
  end

  def inactive_message
    activo? ? super : :account_inactive
  end

  def to_s
    return "" if nombre.nil?
    nombre.titleize
  end

  def caja
    nil
  end

  def cierre_caja_id
    nil
  end

  def cierre_caja_abierta?
    false
  end

  def arqueo_pendiente?
    false
  end

  def sin_arqueo?
    false
  end

  def monto_no_efectivo
    nil
  end

  def monto_sistema
    nil
  end
end
