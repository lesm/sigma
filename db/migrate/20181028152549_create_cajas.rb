class CreateCajas < ActiveRecord::Migration[5.2]
  def change
    create_table :cajas do |t|
      t.string :nombre
      t.text :descripcion
      t.boolean :disponible, default: true

      t.timestamps
    end
  end
end
