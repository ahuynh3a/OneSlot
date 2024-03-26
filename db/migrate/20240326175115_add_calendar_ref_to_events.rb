class AddCalendarRefToEvents < ActiveRecord::Migration[7.0]
  def change
    add_reference :events, :calendar, null: false, foreign_key: true
  end
end
