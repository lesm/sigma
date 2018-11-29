class CreateIngresoPorClasificares < ActiveRecord::Migration[5.2]
  def change
    create_table :ingreso_por_clasificares do |t|
      t.money :monto
      t.references :cajero, foreign_key: { to_table: :usuarios }
      t.references :arqueo, foreign_key: true

      t.timestamps
    end
  end
end
