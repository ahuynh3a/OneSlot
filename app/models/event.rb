# == Schema Information
#
# Table name: events
#
#  id              :bigint           not null, primary key
#  description     :text
#  end_date_time   :datetime
#  location        :string
#  start_date_time :datetime
#  timezone        :string
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  calendar_id     :bigint           not null
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
  belongs_to :calendar

  validates :title, :start_date_time, :end_date_time, :calendar_id, :timezone, presence: true

  validate :start_must_be_before_end

  validates :timezone, inclusion: { in: ActiveSupport::TimeZone.all.map(&:name),
                                    message: "%{value} is not a valid timezone" }

  private

  def start_must_be_before_end
    return if start_date_time.blank? || end_date_time.blank?

    if start_date_time >= end_date_time
      errors.add(:end_date_time, "must be after the start date and time")
    end
  end
end
