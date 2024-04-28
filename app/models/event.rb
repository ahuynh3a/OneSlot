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

class Event < ApplicationRecord
  VALID_TIMEZONES = ActiveSupport::TimeZone.all.map(&:name)

  # Associations
  belongs_to :calendar

  # Validations
  validates :name, :start_time, :end_time, :calendar_id, :timezone, presence: true
  validates :timezone, inclusion: { in: VALID_TIMEZONES, message: "%{value} is not a valid timezone" }
  validate :start_must_be_before_end

  # Scopes for querying events
  scope :upcoming, -> { where("start_time > ?", Time.current).order(:start_time) }
  scope :overlapping, ->(start_date, end_date) {
          where("start_time <= ? AND end_time >= ?", end_date, start_date)
        }
  scope :on_date, ->(date) {
          where(start_time: date.beginning_of_day..date.end_of_day)
        }
  scope :for_members, ->(user_ids) {
          joins(calendar: :owner).where(calendars: { owner_id: user_ids })
        }

  # Class method to group events by their start date
  def self.grouped_by_date
    all.group_by { |event| event.start_time.to_date }
  end

  # Instance method to check if an event spans multiple days
  def multi_day?
    (end_time.to_date - start_time.to_date).to_i > 0
  end

  private

  # Validation method to ensure the event's start time is before its end time
  def start_must_be_before_end
    if start_time.nil? || end_time.nil?
      errors.add(:base, "Start time and end time must both be present.")
    elsif start_time >= end_time
      errors.add(:end_time, "must be after the start time.")
    end
  end
end
