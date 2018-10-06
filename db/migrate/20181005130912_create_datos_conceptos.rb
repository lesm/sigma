class CreateDatosConceptos < ActiveRecord::Migration[5.2]
  def change
    create_table :datos_conceptos do |t|
      t.string :folio
      t.string :clave_catastral
      t.string :numero_cuenta
      t.text :ubicacion
      t.string :base_catastral
      t.string :impuesto_predial
      t.text :observaciones
      t.date :fecha
      t.string :serie
      t.string :placa
      t.string :estimacion
      t.string :nombre_obra
      t.string :localidad
      t.string :nombre_contratista
      t.date :fecha_refrendo
      t.string :type
      t.references :concepto, foreign_key: true

      t.timestamps
    end
  end
end
