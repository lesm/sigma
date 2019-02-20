class CreateTimbres < ActiveRecord::Migration[5.2]
  def change
    create_table :timbres do |t|
      t.string :version
      t.string :no_certificado_sat
      t.string :no_certificado
      t.string :fecha_timbrado
      t.string :uuid
      t.string :sello_sat
      t.string :sello_cfd
      t.string :fecha_comprobante
      t.string :serie
      t.string :rfc_provedor_certificacion
      t.string :folio
      t.references :comprobante, foreign_key: true

      t.timestamps
    end
  end
end
