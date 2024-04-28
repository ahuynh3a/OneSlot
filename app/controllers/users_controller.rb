class UsersController < ApplicationController
  before_action :set_user, only: [:show, :events, :groups]
  before_action :ensure_current_user_is_owner, only: [:show, :events, :groups]

  def show
    @events = @user.events
  end

  def events
    @events = @user.events.upcoming
  end

  def groups
    @groups = @user.groups.includes(:users)
  end

  private

  def set_user
    @user = User.find_by!(username: params[:username])
  end

  def ensure_current_user_is_owner
    unless current_user == @user
      redirect_to root_url, alert: "You are not authorized to access this page."
    end
  end
end
