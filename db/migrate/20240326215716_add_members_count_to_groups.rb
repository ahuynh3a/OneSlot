class AddMembersCountToGroups < ActiveRecord::Migration[7.0]
  def change
    add_column :groups, :members_count, :integer, default: 0
  end
end
