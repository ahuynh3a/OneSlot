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

    private

    def start_must_be_before_end
      errors.add(:end_time, "must be after the start date and time") if start_time >= end_time
    end
  end
