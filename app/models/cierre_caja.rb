class CierreCaja < ApplicationRecord
  belongs_to :cajero
  has_many :arqueos, inverse_of: :cierre_caja, dependent: :destroy
  has_many :adeudos, through: :arqueos
  has_many :ingreso_por_clasificares, through: :arqueos

  validates :monto_sistema, :monto_cajero, :cajero, presence: true

  def update_montos
    update_monto_cajero
    update_monto_sistema
    save!
  end

  def monto_adeudo
    adeudos.map(&:monto).reduce(0,:+)
  end

  def monto_ingreso_por_clasificar
    ingreso_por_clasificares.map(&:monto).reduce(0,:+)
  end

  def fecha_cierre
    return nil if abierta?
    updated_at
  end

  private

  def update_monto_cajero
    self.monto_cajero = arqueos.reload.map(&:monto_cajero).reduce(:+)
  end

  def update_monto_sistema
    self.monto_sistema = arqueos.reload.map(&:monto_sistema).reduce(:+)
  end
end
