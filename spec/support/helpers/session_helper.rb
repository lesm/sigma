module Helper
  module SessionHelpers
    def sign_in_cajero(usuario = cajero)
      sign_in(usuario)
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
