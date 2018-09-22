class Cajero < Usuario
  has_many :cierre_cajas, dependent: :destroy
  has_many :arqueos, through: :cierre_cajas, dependent: :destroy
end
