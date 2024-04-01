class UsersController < ApplicationController

  def show
      @user = User.find_by!(username: params.fetch(:username))
      @events = @user.events
  end

  def calendar
    @user = User.find_by!(username: params.fetch(:username))
  end

  def events
    @user = User.find_by!(username: params.fetch(:username))
  end

  def groups
    @user = User.find_by!(username: params.fetch(:username))
  end

end
