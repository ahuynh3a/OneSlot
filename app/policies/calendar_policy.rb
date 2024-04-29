class CalendarPolicy < ApplicationPolicy
  attr_reader :user, :calendar

  def initialize(user, calendar)
    @user = user
    @calendar = calendar
  end
end
