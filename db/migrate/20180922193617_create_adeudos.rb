class CreateAdeudos < ActiveRecord::Migration[5.2]
  def change
    create_table :adeudos do |t|
      t.decimal :anticipo, default: 0
      t.decimal :monto, default: 0
      t.boolean :liquidado, default: false
      t.references :cajero, foreign_key: { to_table: :usuarios }
      t.references :arqueo, foreign_key: true

      t.timestamps
    end
  end
end
