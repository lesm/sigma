class CreateEmisores < ActiveRecord::Migration[5.2]
  def change
    create_table :emisores do |t|
      t.string :nombre
      t.string :rfc
      t.string :logo
      t.string :regimen_fiscal
      t.string :registro_patronal
      t.string :lugar_expedicion

      t.timestamps
    end
  end
end
