class CreateDirecciones < ActiveRecord::Migration[5.2]
  def change
    create_table :direcciones do |t|
      t.string :calle
      t.string :numero
      t.string :colonia
      t.string :codigo_postal
      t.string :localidad
      t.string :municipio
      t.string :estado, default: 'Oaxaca'
      t.string :pais, default: 'México'

      t.timestamps
    end
  end
end
