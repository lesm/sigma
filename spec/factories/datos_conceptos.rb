FactoryBot.define do
  factory :datos_concepto do
    concepto { nil }
    #serie { "MyString" }
    #placa { "MyString" }
    #estimacion { "MyString" }
    #nombre_obra { "MyString" }
    #localidad { "MyString" }
    #nombre_contratista { "MyString" }
    #fecha_refrendo { "2018-10-05" }

    trait :datos_comun do
      fecha { Date.current }
      observaciones { "Datos comun" }
      type { "DatosComun" }
    end

    trait :datos_predial do
      folio { "MyString" }
      base_catastral { "MyString" }
      fecha { Date.current }
      impuesto_predial { "MyString" }
      clave_catastral { "MyString" }
      numero_cuenta { "MyString" }
      ubicacion { "MyText" }
      observaciones { "MyText" }
      type { "DatosPredial" }
    end
  end
end
