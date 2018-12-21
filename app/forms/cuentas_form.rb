class CuentasForm < ReporteForm
  validates :fecha_inicial, :fecha_final, presence: true
end
