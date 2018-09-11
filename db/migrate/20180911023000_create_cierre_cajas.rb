class CreateCierreCajas < ActiveRecord::Migration[5.2]
  def change
    create_table :cierre_cajas do |t|
      t.decimal :monto
      t.text :observacion
      t.references :usuario, foreign_key: true

      t.timestamps
    end
  end
end
