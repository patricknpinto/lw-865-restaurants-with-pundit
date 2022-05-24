class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # scope.where(status: 'published')
      # scope.where(user: user)
      scope.all
    end
  end

  def create?
    true # this means EVERYONE can create a restaurant
  end

  def show?
    true
  end

  def publish?
    owner_or_admin?
  end

  def update?
    # only the user who created the restaurant is able to update that restaurant
    # user - the collged in user at the moment
    # record - the instance of the model we are trying to authorize - a Restaurant in this case
    owner_or_admin?
  end

  def destroy?
    owner_or_admin?
  end

  private

  def owner_or_admin?
    record.user == user || user.admin?
  end
end
