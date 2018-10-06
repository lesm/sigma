class DatosMercado < DatosConcepto
  validates :cantidad_folios_cinco, :cantidad_folios_diez, :responsable,
    :fecha, presence: true
end
