class UserPolicy < ApplicationPolicy
  attr_reader :user, :current_user

  def initialize(user, current_user)
    @user = user
    @current_user = current_user
  end

  def show?
    user_is_current_user?
  end

  def events?
    user_is_current_user?
  end

  def groups?
    user_is_current_user?
  end

  private

  def user_is_current_user?
    user == current_user
  end
end
