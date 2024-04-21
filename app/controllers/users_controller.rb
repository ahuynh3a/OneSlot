class UsersController < ApplicationController
  before_action :set_user, only: [:show, :events, :groups]

  def show
    @events = @user.events

  end


  def events
    @events = @user.events.where('start_time > ?', Time.current.in_time_zone(@user.timezone)).order(:start_time)
  end

  def groups
    @groups = @user.groups.includes(:users)
  end

  private

  def set_user
    @user = User.find_by!(username: params[:username])
  end

end
