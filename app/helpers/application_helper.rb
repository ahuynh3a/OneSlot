module ApplicationHelper
  def convert_event_times_to_user_time_zone(event, user_time_zone)
    start_time_in_user_zone = event.start_time.in_time_zone(event.timezone).in_time_zone(user_time_zone)
    end_time_in_user_zone = event.end_time.in_time_zone(event.timezone).in_time_zone(user_time_zone)

    [start_time_in_user_zone, end_time_in_user_zone]
  end


  def available_times_for(date, events)
    day_start = date.beginning_of_day
    day_end = date.end_of_day

    all_slots = (0...96).map { |i| day_start + (i * 15).minutes }.select { |time| time < day_end }

    occupied_slots = events.flat_map do |event|
      event_start = event.start_time
      event_end = event.end_time

      (event_start.to_i..event_end.to_i).step(15.minutes).map do |timestamp|
        Time.zone.at(timestamp)
      end
    end

    available_slots = all_slots.reject { |slot| occupied_slots.include?(slot) }

    merge_consecutive_slots(available_slots)
  end


  def merge_consecutive_slots(slots)
    merged = slots.slice_when { |i, j| j != i + 15.minutes }.to_a
    merged.map do |range|
      "#{range.first.strftime("%I:%M %p")} - #{(range.last + 15.minutes).strftime("%I:%M %p")}"
    end
  end
end
