class Cajero < Usuario
  has_one :contribuyente, dependent: :destroy
  has_many :cierre_cajas, dependent: :destroy
  has_many :arqueos, through: :cierre_cajas, dependent: :destroy
  has_many :adeudos, dependent: :destroy

  accepts_nested_attributes_for :contribuyente, allow_destroy: true

  before_create :set_rol

  def to_s
    nombre.capitalize
  end

  private

  def set_rol
    self.rol = 1
  end
end
