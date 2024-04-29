class GroupPolicy < ApplicationPolicy
  attr_reader :user, :group

  def initialize(user, group)
    @user = user
    @group = group
  end

  def show?
    user_is_owner? || group.users.include?(user)
  end

  def update?
    user_is_owner?
  end

  def edit?
    update?
  end

  def destroy?
    user_is_owner?
  end

  def leave?
    group.users.include?(user) && !user_is_owner?
  end

  private

  def user_is_owner?
    user == group.owner
  end
end
