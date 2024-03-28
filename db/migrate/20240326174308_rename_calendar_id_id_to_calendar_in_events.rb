class RenameCalendarIdIdToCalendarInEvents < ActiveRecord::Migration[7.0]
  def change
    rename_column :events, :calendar_id_id, :calendar
  end
end
