class AddConCertificadoAttributeToEmisor < ActiveRecord::Migration[5.2]
  def change
    add_column :emisores, :con_certificado, :boolean, default: false
  end
end
