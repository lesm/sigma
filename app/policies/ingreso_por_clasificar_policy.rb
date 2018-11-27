class IngresoPorClasificarPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      raise Pundit::NotAuthorizedError unless user.cajero?
      scope.all
    end
  end
end
