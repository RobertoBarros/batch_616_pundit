# Pundit variables:
#
# user == current_user
# record == model

class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.first(10)
      end
    end
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    record.user == user || user.admin?
  end

  def destroy?
    user.admin?
  end

end
