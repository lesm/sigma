class CreateContribuyentes < ActiveRecord::Migration[5.2]
  def change
    create_table :contribuyentes do |t|
      t.string :nombre_o_razon_social
      t.string :primer_apellido
      t.string :segundo_apellido
      t.boolean :persona_fisica, default: true
      t.string :email
      t.string :rfc

      t.timestamps
    end
  end
end
