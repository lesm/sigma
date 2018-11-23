class ArqueoPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      raise Pundit::NotAuthorizedError, "Usuario sin permisos." unless user.cajero?
      user.arqueos
    end
  end

  def show?
    return false unless user.cajero?
    user.arqueos.include? record
  end

  def create?
    user.cajero?
  end

  def new?
    create?
  end
end
