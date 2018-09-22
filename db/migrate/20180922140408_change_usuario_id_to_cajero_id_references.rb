class ChangeUsuarioIdToCajeroIdReferences < ActiveRecord::Migration[5.2]
  def change
    remove_reference :cierre_cajas, :usuario, index: true, foreign_key: true
    add_reference :cierre_cajas, :cajero, foreign_key: { to_table: :usuarios }
  end
end
