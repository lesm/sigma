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
      sequence(:folio) { |n| "482181-#{n}" }
      base_catastral { "01020101020921" }
      fecha { Date.current }
      impuesto_predial { 250 }
      clave_catastral { "233223" }
      numero_cuenta { "23322213" }
      ubicacion { "A lada de mi casa" }
      observaciones { "Terreno grande" }
      years { ["2015", "2016"] }
      type { "DatosPredial" }
    end

    trait :licencia_comercial do
      sequence(:folio) { |n| "482181-#{n}" }
      serie { "AA" }
      observaciones { "Pago de 2015"}
      fecha_refrendo { Date.current }
      fecha { Date.current }
      years { ["2015", "2016"] }
      type { "DatosLicenciaComercial" }
    end
  end
end
