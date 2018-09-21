class Dinero < ApplicationRecord
  belongs_to :arqueo

  validates :diez_centavos, :veinte_centavos, :cincuenta_centavos,
    :un_peso, :dos_pesos, :cinco_pesos, :diez_pesos, :veinte_pesos,
    :cincuenta_pesos, :cien_pesos, :doscientos_pesos, :quinientos_pesos,
    :mil_pesos, :dos_mil_pesos, :total, numericality: { greater_than_or_equal_to: 0 }
end
