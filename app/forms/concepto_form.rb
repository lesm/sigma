class ConceptoForm < ReporteForm
  validates :cuenta_id, :fecha_inicial, :fecha_final, presence: true
end
