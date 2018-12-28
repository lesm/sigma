FactoryBot.define do
  factory :cuenta do
    codigo { "110101" }
    sequence(:descripcion) { |n| "RIFAS#{n}" }
    formato { "DatosComun" }
    clave_unidad { "E48 - Unidad de servicio" }
    clave_producto { "93161700 - Administración tributaria" }

    trait :rifas do
      after :build do |cuenta|
        cuenta.codigo = "110101"
        cuenta.descripcion = "110101 - RIFAS"
        cuenta.clave_producto = "93161700 - Administración tributaria"
        cuenta.formato = "DatosComun"
      end
    end

    trait :sorteos do
      after :build do |cuenta|
        cuenta.codigo = "110102"
        cuenta.descripcion = "110102 - SORTEOS"
        cuenta.clave_producto = "93161700 - Administración tributaria"
        cuenta.formato = "DatosComun"
      end
    end

    trait :loterias do
      after :build do |cuenta|
        cuenta.codigo = "110103"
        cuenta.descripcion = "110103 - LOTERÍAS"
        cuenta.clave_producto = "93161700 - Administración tributaria"
        cuenta.formato = "DatosComun"
      end
    end

    trait :teatros do
      after :build do |cuenta|
        cuenta.codigo = "110201"
        cuenta.descripcion = "110201 - TEATROS"
        cuenta.clave_producto = "93161700 - Administración tributaria"
        cuenta.formato = "DatosComun"
      end
    end

    trait :de_licencias_y_refrendos do
      after :build do |cuenta|
        cuenta.codigo = "430601"
        cuenta.descripcion = "430601 - LICENCIAS Y REFRENDOS COMERCIAL"
        cuenta.clave_producto = "93171500 - Política comercial"
        cuenta.formato = "DatosLicenciaComercial"
      end
    end

    trait :predial_urbano do
      after :build do |cuenta|
        cuenta.codigo = "120101"
        cuenta.descripcion = "120101 - PREDIAL URBANOS"
        cuenta.clave_producto = "93161700 - Administración tributaria"
        cuenta.formato = "DatosPredial"
      end
    end
  end
end
