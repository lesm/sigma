module Helper
  module SessionHelpers
    def sign_in_super_user(usuario = create_super_user)
      sign_in(usuario)
    end

    def sign_in_cajero(usuario = create_cajero)
      sign_in(usuario)
    end

    def sign_in_admin(usuario = create_admin)
      sign_in(usuario)
    end

    def sign_in_admin_with_municipio(usuario = create_admin)
      registra_municipio
      sign_in(usuario)
    end

    def registra_municipio
      create :emisor, :con_direccion
    end

    def create_super_user
      create :usuario, :super_user
    end

    def create_admin
      create :administrador
    end

    def create_cajero
      create :cajero,
        contribuyente: build_contribuyente,
        caja: caja
    end

    def build_contribuyente
      build :contribuyente, :con_direccion
    end

    def caja
      build :caja
    end
  end
end
