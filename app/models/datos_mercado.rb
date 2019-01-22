class DatosMercado < DatosConcepto
  validates :cantidad_folios_cinco, :cantidad_folios_diez, :responsable,
    :fecha, presence: true
  validates :cantidad_folios_cinco, :cantidad_folios_diez,
    numericality: { greater_than_or_equal_to: 0 }
end
