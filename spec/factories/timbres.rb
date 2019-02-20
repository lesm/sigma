FactoryBot.define do
  factory :timbre do
    version { "MyString" }
    no_certificado_sat { "MyString" }
    no_certificado { "MyString" }
    fecha_timbrado { "MyString" }
    uuid { "MyString" }
    sello_sat { "MyString" }
    sello_cfd { "MyString" }
    fecha_comprobante { "MyString" }
    serie { "MyString" }
    rfc_provedor_certificacion { "MyString" }
    folio { "MyString" }
    comprobante { nil }
  end
end
