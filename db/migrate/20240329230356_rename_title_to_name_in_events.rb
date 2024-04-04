class RenameTitleToNameInEvents < ActiveRecord::Migration[7.0]
  def change
    rename_column :events, :title, :name
  end
end
