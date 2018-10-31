class Usuario < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  enum rol: { sin_rol: 0, cajero: 1, reporte: 2, admin: 3 }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

  validates :nombre, :username, presence: true

  def email_required?
    false
  end

  def active_for_authentication?
    super && activo?
  end

  def inactive_message
    activo? ? super : :account_inactive
  end
end
