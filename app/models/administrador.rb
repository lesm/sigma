class Administrador < Usuario
  before_create :set_rol

  private

  def set_rol
    self.rol = 3
  end
end
