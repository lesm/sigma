class ReciboStepPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    user.cajero?
  end

  def update?
    show?
  end
end
