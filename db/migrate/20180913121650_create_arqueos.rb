class CreateArqueos < ActiveRecord::Migration[5.2]
  def change
    create_table :arqueos do |t|
      t.decimal :monto
      t.text :observacion
      t.references :cierre_caja, foreign_key: true

      t.timestamps
    end
  end
end
