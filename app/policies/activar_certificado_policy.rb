class ActivarCertificadoPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      raise NotImplementedError
    end
  end

  def new?
    create?
  end

  def create?
    user.admin?
  end
end
