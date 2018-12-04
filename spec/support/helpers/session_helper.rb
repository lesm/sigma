module Helper
  module SessionHelpers
    def sign_in_cajero(usuario = cajero)
      sign_in(usuario)
    end

    def sign_in_admin(usuario = admin)
      sign_in(usuario)
    end

    def sign_in_admin_with_municipio(usuario = admin)
      registra_municipio
      sign_in(usuario)
    end

    def registra_municipio
      create :emisor, :con_direccion
    end

    def admin
      create :usuario, :admin
    end

    def cajero
      create :cajero,
        contribuyente: contribuyente,
        caja: caja
    end

    def contribuyente
      build :contribuyente, :con_direccion
    end

    def caja
      build :caja
    end
  end
end
