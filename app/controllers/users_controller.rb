class UsersController < ApplicationController
  before_action :set_user, only: [:show, :events, :groups]
  before_action :authorize_user, only: [:show, :events, :groups]

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

  def authorize_user
    authorize @user
  end
end
