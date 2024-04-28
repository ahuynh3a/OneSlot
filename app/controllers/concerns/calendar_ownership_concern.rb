# app/controllers/concerns/calendar_ownership_concern.rb
module CalendarOwnershipConcern
  extend ActiveSupport::Concern

  def ensure_current_user_is_owner_of_calendar
    calendar = find_calendar
    unless current_user == calendar.owner
      redirect_back fallback_location: root_path, alert: "You do not have permission to modify this #{resource_name}. Please contact the owner if you believe this is an error."
    end
  end

  def find_calendar
    if controller_name == "calendars"
      @calendar
    elsif controller_name == "events"
      @event.calendar
    end
  end

  def resource_name
    if controller_name == "calendars"
      "calendar"
    elsif controller_name == "events"
      "event"
    else
      "resource"
    end
  end
end
