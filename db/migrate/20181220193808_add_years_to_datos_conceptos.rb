class AddYearsToDatosConceptos < ActiveRecord::Migration[5.2]
  def change
    add_column :datos_conceptos, :years, :text, array:true, default: []
  end
end
