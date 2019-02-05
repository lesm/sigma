class ContribuyentesCuenta < ApplicationRecord
  belongs_to :contribuyente
  belongs_to :cuenta
end
