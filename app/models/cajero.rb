class Cajero < Usuario
  has_many :cierre_cajas, dependent: :destroy
  has_many :arqueos, through: :cierre_cajas, dependent: :destroy
  has_many :adeudos, dependent: :destroy

  def to_s
    nombre.capitalize
  end
end
