class CreateDineros < ActiveRecord::Migration[5.2]
  def change
    create_table :dineros do |t|
      t.integer :diez_centavos, default: 0
      t.integer :veinte_centavos, default: 0
      t.integer :cincuenta_centavos, default: 0
      t.integer :un_peso, default: 0
      t.integer :dos_pesos, default: 0
      t.integer :cinco_pesos, default: 0
      t.integer :diez_pesos, default: 0
      t.integer :veinte_pesos, default: 0
      t.integer :veinte_m_pesos, default: 0
      t.integer :cincuenta_pesos, default: 0
      t.integer :cien_pesos, default: 0
      t.integer :doscientos_pesos, default: 0
      t.integer :quinientos_pesos, default: 0
      t.integer :mil_pesos, default: 0
      t.integer :dos_mil_pesos, default: 0
      t.money :total, default: 0
      t.references :arqueo, foreign_key: true

      t.timestamps
    end
  end
end
