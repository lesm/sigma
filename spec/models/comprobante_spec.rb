require 'rails_helper'

RSpec.describe Comprobante, type: :model do
  it { should belong_to :arqueo }
  it { should belong_to :cajero }
  it { should belong_to :contribuyente }
  it { should belong_to :emisor }

  it { should validate_presence_of :folio }
  it { should validate_presence_of :moneda }
  it { should validate_presence_of :tipo_comprobante }
  it { should validate_presence_of :lugar_expedicion }
  it { should validate_presence_of :metodo_pago }
  it { should validate_presence_of :forma_pago }
  it { should validate_presence_of :subtotal }
  it { should validate_presence_of :descuento }
  it { should validate_presence_of :total }
end
