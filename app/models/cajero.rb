class Cajero < Usuario
  belongs_to :contribuyente
  has_one :caja

  has_many :cierre_cajas, dependent: :destroy
  has_many :arqueos, through: :cierre_cajas, dependent: :destroy
  has_many :adeudos, dependent: :destroy
  has_many :ingreso_por_clasificares, dependent: :destroy
  has_many :recibos
  has_many :facturas

  accepts_nested_attributes_for :contribuyente, allow_destroy: true

  before_create :set_rol

  def sin_arqueo?
    arqueos_actuales.count == 0
  end

  def cierre_caja_id
    return nil unless cierre_caja_abierta?
    ultimo_cierre_caja.id
  end

  def cierre_caja_abierta?
    return false if ultimo_cierre_caja.nil?
    ultimo_cierre_caja.abierta?
  end

  def arqueo_pendiente?
    return false if caja.nil?
    monto_sistema > 0
  end

  def monto_no_efectivo
    Comprobante.monto_no_efectivo(self)
  end

  def monto_sistema
    Comprobante.total_monto_sistema(self)
  end

  def ultimo_cierre_caja
    cierre_cajas.where(created_at: rango_fecha).last
  end

  private

  def set_rol
    self.rol = 1
  end

  def arqueos_actuales
    arqueos.where(created_at: rango_fecha)
  end

  def rango_fecha
    Date.current.beginning_of_day..Date.current.end_of_day
  end
end
