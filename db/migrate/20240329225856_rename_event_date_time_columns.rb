class RenameEventDateTimeColumns < ActiveRecord::Migration[7.0]
  def change
    rename_column :events, :start_date_time, :start_time
    rename_column :events, :end_date_time, :end_time
  end
end
