class EventPolicy < ApplicationPolicy
  attr_reader :user, :event

  def initialize(user, event)
    @user = user
    @event = event
  end

  def show?
    manage_event?
  end

  def update?
    manage_event?
  end

  def edit?
    update?
  end

  def destroy?
    manage_event?
  end

  private

  def manage_event?
    user == event.calendar.owner
  end
end
