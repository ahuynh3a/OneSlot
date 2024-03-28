class CreateCalendars < ActiveRecord::Migration[7.0]
  def change
    create_table :calendars do |t|
      t.references :owner, null: false, foreign_key: {to_table: :users}
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
