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
end
