class RenameMembersCountToMembershipsCountInGroups < ActiveRecord::Migration[7.0]
  def change
    rename_column :groups, :members_count, :memberships_count
  end
end
