# == Schema Information
#
# Table name: events
#
#  id          :bigint           not null, primary key
#  description :text
#  end_time    :datetime
#  location    :string
#  name        :string
#  start_time  :datetime
#  timezone    :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  calendar_id :bigint           not null
#
# Indexes
#
#  index_events_on_calendar_id  (calendar_id)
#
# Foreign Keys
#
#  fk_rails_...  (calendar_id => calendars.id)
#
class Event < ApplicationRecord

    # Constants
    VALID_TIMEZONES = ActiveSupport::TimeZone.all.map(&:name)

    belongs_to :calendar

    # Validations
    validates :name, :start_time, :end_time, :calendar_id, :timezone, presence: true
    validate :start_must_be_before_end
    validates :timezone, inclusion: { in: VALID_TIMEZONES, message: "%{value} is not a valid timezone" }

    # Scopes
    scope :upcoming, -> { where("start_time > ?", Time.current).order(start_time: :asc) }
    scope :overlapping, ->(start_date, end_date) {
      where("start_time <= ? AND end_time >= ?", end_date, start_date)
    }
    # Event.where(calendar_id: []).available_times_for()
    #scope :available_times_for, ->(date) do
      # TODO
   # end

   def multi_day?
    # Assuming 'start_time' and 'end_time' are attributes of your event
    (end_time.to_date - start_time.to_date).to_i > 0
  end
    private

    def start_must_be_before_end
      if start_time.nil? || end_time.nil?
        errors.add(:base, "Start time and end time must both be present")
      elsif start_time >= end_time
        errors.add(:end_time, "must be after the start date and time")
      end
    end
  end
