FactoryBot.define do
  factory :dinero do
    diez_centavos { 1 }
    veinte_centavos { 1 }
    cincuenta_centavos { 1 }
    un_peso { 1 }
    dos_pesos { 1 }
    cinco_pesos { 1 }
    diez_pesos { 1 }
    veinte_pesos { 1 }
    cincuenta_pesos { 1 }
    cien_pesos { 1 }
    doscientos_pesos { 1 }
    quinientos_pesos { 1 }
    mil_pesos { 1 }
    dos_mil_pesos { 1 }
    total { "9.99" }
    arqueo { nil }
  end
end
