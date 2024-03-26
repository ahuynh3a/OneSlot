class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.references :calendar_id, null: false, foreign_key: { to_table: :calendars}
      t.datetime :start_date_time
      t.datetime :end_date_time
      t.string :timezone
      t.string :location

      t.timestamps
    end
  end
end
