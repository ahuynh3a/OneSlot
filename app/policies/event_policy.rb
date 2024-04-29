class EventPolicy < ApplicationPolicy
  attr_reader :user, :event

  def initialize(user, event)
    @user = user
    @event = event
  end

  # Create and new actions use the same permission logic.
  def create?
    manage_event?
  end

  def new?
    create?
  end

  # Show, update, edit, and destroy actions check if the user can manage the event.
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

  # Manage event checks if the event is associated with a calendar and if the user is the owner.
  def manage_event?
    event.present? && event.calendar.present? && user == event.calendar.owner
  end
end
