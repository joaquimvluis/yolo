class UserTaskPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      # scope.all
      scope.where(user: user)
    end
  end

  def update?
    record.user == user
  end
end
