class RemoveCalendarFromEvents < ActiveRecord::Migration[7.0]
  def change
    remove_column :events, :calendar, :bigint
  end
end
