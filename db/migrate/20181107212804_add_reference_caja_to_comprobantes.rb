class AddReferenceCajaToComprobantes < ActiveRecord::Migration[5.2]
  def change
    add_reference :comprobantes, :caja, foreign_key: true
  end
end
