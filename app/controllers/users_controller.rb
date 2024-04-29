class UsersController < ApplicationController
  before_action :set_user, only: [:show, :events, :groups]
  before_action :authorize_user, only: [:show, :events, :groups]

  def show
    @events = @user.events
  end

  def events
    @events = @user.events.upcoming.page(params[:page]).per(5)
  end

  def groups
    @q = @user.groups.ransack(params[:q])
    @groups = @q.result.includes(:users).distinct
  end

  private

  def set_user
    @user = User.find_by(username: params[:username])
    unless @user
      user_not_authorized
      return 
    end
  end

  def authorize_user
    authorize @user
  end
end
