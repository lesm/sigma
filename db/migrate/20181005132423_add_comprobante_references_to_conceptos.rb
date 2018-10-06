class AddComprobanteReferencesToConceptos < ActiveRecord::Migration[5.2]
  def change
    add_reference :conceptos, :comprobante, foreign_key: true
  end
end
