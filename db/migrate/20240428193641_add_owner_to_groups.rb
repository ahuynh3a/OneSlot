class AddOwnerToGroups < ActiveRecord::Migration[7.0]
  def change
    add_column :groups, :owner_id, :bigint
    add_index :groups, :owner_id
  end
end
