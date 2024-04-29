class MembershipPolicy < ApplicationPolicy
  attr_reader :user, :membership

  def initialize(user, membership)
    @user = user
    @membership = membership
  end

  def new?
    user_is_owner?
  end

  def create?
    user_is_owner?
  end

  def update?
    user_is_owner?
  end

  def edit?
    update?
  end

  def destroy?
    user_is_owner? || group.users.include?(user)
  end

  private
  
  def group
    membership.group
  end

  def user_is_owner?
    user == membership.group.owner
  end
end
