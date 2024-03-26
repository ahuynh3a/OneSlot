# == Schema Information
#
# Table name: memberships
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  group_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_memberships_on_group_id  (group_id)
#  index_memberships_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#  fk_rails_...  (user_id => users.id)
#
class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :group, counter_cache: true
end
