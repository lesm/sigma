class Arqueo < ApplicationRecord
  belongs_to :cierre_caja, inverse_of: :arqueos
  has_many :recibos
  has_many :facturas
  has_one :dinero, dependent: :destroy
  has_one :adeudo, dependent: :destroy

  accepts_nested_attributes_for :dinero, allow_destroy: true

  validates :monto_sistema, :monto_cajero, presence: true
  validates :monto_sistema, :monto_cajero, numericality: { greater_than: 0 }

  after_save :update_montos_cierre_caja
  after_create :crear_adeudo

  private

  def update_montos_cierre_caja
    cierre_caja.update_montos
  end

  def crear_adeudo
    if monto_cajero_menor_a_monto_sistema?
      Adeudo.create monto: adeudo_monto, arqueo: self,
        cajero: cierre_caja.cajero
    end
  end

  def monto_cajero_menor_a_monto_sistema?
    monto_cajero < monto_sistema
  end

  def adeudo_monto
    monto_sistema - monto_cajero
  end
end
