class AddFacturaGlobalToComprobantes < ActiveRecord::Migration[5.2]
  def change
    add_reference :comprobantes, :factura_global, foreign_key: { to_table: :comprobantes }
  end
end
