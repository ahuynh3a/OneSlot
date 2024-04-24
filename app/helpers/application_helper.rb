module ApplicationHelper
  def convert_event_times_to_user_time_zone(event, user_time_zone)
    start_time_in_user_zone = event.start_time.in_time_zone(event.timezone).in_time_zone(user_time_zone)
    end_time_in_user_zone = event.end_time.in_time_zone(event.timezone).in_time_zone(user_time_zone)

    [start_time_in_user_zone, end_time_in_user_zone]
  end
end
