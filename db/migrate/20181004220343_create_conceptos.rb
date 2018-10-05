class CreateConceptos < ActiveRecord::Migration[5.2]
  def change
    create_table :conceptos do |t|
      t.string :clave
      t.string :clave_unidad
      t.string :unidad
      t.decimal :cantidad, default: 1
      t.string :descripcion
      t.money :valor_unitario
      t.money :importe
      t.references :cuenta, foreign_key: true

      t.timestamps
    end
  end
end
