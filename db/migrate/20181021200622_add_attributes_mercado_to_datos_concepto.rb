class AddAttributesMercadoToDatosConcepto < ActiveRecord::Migration[5.2]
  def change
    add_column :datos_conceptos, :cantidad_folios_cinco, :integer, default: 0
    add_column :datos_conceptos, :cantidad_folios_diez, :integer, default: 0
    add_column :datos_conceptos, :responsable, :string
  end
end
