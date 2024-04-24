# app/services/schedule_analyzer.rb
class ScheduleAnalyzer
  def initialize(events)
    @events = events
  end

  def compute_available_times_for_each_date
    @events.grouped_by_date.transform_values do |events_on_a_day|
      calculate_free_time_slots(events_on_a_day)
    end
  end

  private

  # Calculates free time slots available on a given day by subtracting occupied slots from total slots.
  def calculate_free_time_slots(events_on_a_day)
    date = events_on_a_day.first.start_time.to_date
    time_slots = time_slots_for_each_day(date)
    occupied_slots = occupied_time_slots(events_on_a_day)

    merge_time_slots(time_slots - occupied_slots)
  end

  # Generates all possible 15-minute time slots for a given day from the start to the end of the day.
  def time_slots_for_each_day(date)
    start_time = date.beginning_of_day
    end_time = date.end_of_day
    (0...96).map { |i| start_time + i * 15.minutes }.select { |t| t < end_time }
  end

  # Determines which time slots are occupied by events on a given day.
  def occupied_time_slots(events_on_a_day)
    events_on_a_day.flat_map do |event|
      time_range_for_event(event).step(15.minutes).map(&Time.zone.method(:at))
    end.uniq
  end

  # Expands the event time to cover the entire 15-minute time slots it occupies.
  def time_range_for_event(event)
    start_adjustment = event.start_time.min % 15
    end_adjustment = 15 - event.end_time.min % 15

    (event.start_time - start_adjustment.minutes - conditional_minute(event.start_time.sec)).to_i..(event.end_time + end_adjustment.minutes + conditional_minute(event.end_time.sec)).to_i
  end

  # Helper method to adjust time based on seconds, adding a minute if seconds are non-zero.
  def conditional_minute(seconds)
    seconds > 0 ? 1.minute : 0.minutes
  end

  # Merges adjacent free time slots into continuous ranges.
  def merge_time_slots(slots)
    slots.slice_when { |prev, curr| curr != prev + 15.minutes }
         .map { |range| format_range(range) }
  end

  # Formats a given time range into a readable string format.
  def format_range(range)
    start_time = range.first.strftime("%I:%M %p")
    end_time = format_end_time(range.last + 15.minutes)
    "#{start_time} - #{end_time}"
  end

  # Adjusts the end time display to handle the case where the time rounds up to midnight.
  def format_end_time(time)
    time.strftime("%I:%M %p") == "12:00 AM" ? "11:59 PM" : time.strftime("%I:%M %p")
  end
end
