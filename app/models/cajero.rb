class Cajero < Usuario
  belongs_to :contribuyente
  has_one :caja

  has_many :cierre_cajas, dependent: :destroy
  has_many :arqueos, through: :cierre_cajas, dependent: :destroy
  has_many :adeudos, dependent: :destroy
  has_many :recibos
  has_many :facturas

  accepts_nested_attributes_for :contribuyente, allow_destroy: true

  before_create :set_rol

  def to_s
    nombre.capitalize
  end

  def ultimo_cierre_caja
    cierre_cajas.last
  end

  private

  def set_rol
    self.rol = 1
  end
end
