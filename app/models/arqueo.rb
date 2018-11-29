class Arqueo < ApplicationRecord
  belongs_to :cierre_caja, inverse_of: :arqueos
  has_many :recibos
  has_many :facturas
  has_one :dinero, dependent: :destroy
  has_one :adeudo, dependent: :destroy
  has_one :ingreso_por_clasificar, dependent: :destroy

  accepts_nested_attributes_for :dinero, allow_destroy: true

  validates :monto_sistema, :monto_cajero, presence: true
  validates :monto_sistema, :monto_cajero, numericality: {
    greater_than_or_equal_to: 0
  }

  after_save :update_montos_cierre_caja
  after_create :crear_adeudo
  after_create :crear_ingreso_por_clasificar

  def monto_cheque
    Comprobante.where(arqueo_id: id).de_cheque.sum(:total)
  end

  def monto_debito
    Comprobante.where(arqueo_id: id).de_debito.sum(:total)
  end

  def monto_credito
    Comprobante.where(arqueo_id: id).de_credito.sum(:total)
  end

  def monto_transferencia
    Comprobante.where(arqueo_id: id).de_transferencia.sum(:total)
  end

  def monto_efectivo
    DineroPresenter.new(dinero).total
  end

  def monto_no_efectivo
    monto_cheque + monto_debito + monto_credito + monto_transferencia
  end

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

  def crear_ingreso_por_clasificar
    if monto_cajero_mayor_a_monto_sistema?
      IngresoPorClasificar.create monto: ingreso_por_clasificar_monto,
        arqueo: self, cajero: cierre_caja.cajero
    end
  end

  def monto_cajero_mayor_a_monto_sistema?
    monto_cajero > monto_sistema
  end

  def ingreso_por_clasificar_monto
    monto_cajero - monto_sistema
  end
end
