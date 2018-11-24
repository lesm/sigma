class CierreCajaPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      raise Pundit::NotAuthorizedError unless user.cajero?
      user.cierre_cajas
    end
  end

  def create?
    user.cajero?
  end

  def show?
    user == record.cajero
  end

  def edit?
    show?
  end

  def update?
    show?
  end

  def cerrar?
    show?
  end
end
