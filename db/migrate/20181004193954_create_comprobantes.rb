class CreateComprobantes < ActiveRecord::Migration[5.2]
  def change
    create_table :comprobantes do |t|
      t.string :serie
      t.string :folio
      t.string :moneda, default: "MXN"
      t.string :tipo_comprobante
      t.string :lugar_expedicion
      t.string :metodo_pago, default: "Pago en una sola exhibición"
      t.string :forma_pago
      t.money :subtotal, default: 0
      t.money :descuento, default: 0
      t.money :total, default: 0
      t.string :type
      t.string :cbb
      t.string :xml
      t.string :pdf
      t.string :estado
      t.text :respuesta_timbrado
      t.string :motivo_descuento
      t.datetime :fecha_emision
      t.text :observaciones
      t.references :cajero, foreign_key: { to_table: :usuarios }
      t.references :contribuyente, foreign_key: true
      t.references :emisor, foreign_key: true
      t.references :arqueo, foreign_key: true

      t.timestamps
    end
  end
end
