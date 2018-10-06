class AddAttributesAguaToDatosConcepto < ActiveRecord::Migration[5.2]
  def change
    add_column :datos_conceptos, :numero_contrato, :string
    add_column :datos_conceptos, :numero_medidor, :string
    add_column :datos_conceptos, :lectura_actual, :decimal, precision: 8, scale: 2, default: 0.0
    add_column :datos_conceptos, :lectura_anterior, :decimal, precision: 8,scale: 2, default: 0.0
    add_column :datos_conceptos, :consumo, :decimal, precision: 8, scale: 2, default: 0.0
    add_column :datos_conceptos, :ruta, :string
    add_column :datos_conceptos, :lecturista, :string
    add_column :datos_conceptos, :fecha_corte, :date
    add_column :datos_conceptos, :mes_pago, :date
  end
end
