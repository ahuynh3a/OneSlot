module ApplicationHelper
  def convert_event_times_to_user_time_zone(event, user_time_zone)
    start_time_in_user_zone = event.start_time.in_time_zone(event.timezone).in_time_zone(user_time_zone)
    end_time_in_user_zone = event.end_time.in_time_zone(event.timezone).in_time_zone(user_time_zone)

    [start_time_in_user_zone, end_time_in_user_zone]
  end

    def available_times_for(date, events)
      day_start = date.beginning_of_day
      day_end = date.end_of_day

      # Generate all potential 15-minute time slots for the day
      all_slots = (0...96).map { |i| day_start + (i * 15).minutes }.select { |time| time < day_end }

      # Calculate occupied slots from event times, adjusting to ensure full coverage
      occupied_slots = events.flat_map do |event|
        event_start = event.start_time
        event_end = event.end_time

        # Adjust start and end times to cover the entire event range
        adjusted_start = event_start - (event_start.min % 15).minutes - (event_start.sec > 0 ? 1 : 0).minutes
        adjusted_end = event_end + (15 - event_end.min % 15).minutes + (event_end.sec > 0 ? 1 : 0).minutes

        (adjusted_start.to_i..adjusted_end.to_i).step(15.minutes).map do |timestamp|
          Time.zone.at(timestamp)
        end
      end.uniq

      # Determine slots that are not occupied
      available_slots = all_slots.reject { |slot| occupied_slots.include?(slot) }

      # Merge consecutive available time slots
      merge_consecutive_slots(available_slots)
    end

    def merge_consecutive_slots(slots)
      merged = slots.slice_when { |i, j| j != i + 15.minutes }.to_a
      merged.map do |range|
        start_time = range.first.strftime("%I:%M %p")
        end_time = range.last + 15.minutes

        end_time_str = if end_time.strftime("%I:%M %p") == "12:00 AM"
                         "11:59 PM"
                       else
                         end_time.strftime("%I:%M %p")
                       end

        "#{start_time} - #{end_time_str}"
      end
    end
  end
