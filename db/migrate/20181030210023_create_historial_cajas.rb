class CreateHistorialCajas < ActiveRecord::Migration[5.2]
  def change
    create_table :historial_cajas do |t|
      t.references :caja, foreign_key: true
      t.references :cajero, foreign_key: { to_table: :usuarios }
      t.datetime :fecha_cierre

      t.timestamps
    end
  end
end
