class AddDefaultValueToRegimenFiscalToEmisor < ActiveRecord::Migration[5.2]
  def change
    change_column_default :emisores, :regimen_fiscal, from: nil, to: "Personas morales con fines no lucrativos"
  end
end
