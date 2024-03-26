class SetDefaultTimezoneInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :timezone, 'UTC'
  end
end
