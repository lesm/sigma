class AddCajeroIdToCajas < ActiveRecord::Migration[5.2]
  def change
    add_reference :cajas, :cajero, foreign_key: { to_table: :usuarios }
  end
end
