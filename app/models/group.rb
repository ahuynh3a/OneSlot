# == Schema Information
#
# Table name: groups
#
#  id                :bigint           not null, primary key
#  description       :text
#  memberships_count :integer          default(0)
#  name              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  owner_id          :bigint
#
# Indexes
#
#  index_groups_on_owner_id  (owner_id)
#
class Group < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  belongs_to :owner, class_name: "User", foreign_key: "owner_id"

  validates :name, presence: true

  scope :search, ->(query) {
          where("LOWER(name) LIKE LOWER(:query) OR LOWER(description) LIKE LOWER(:query)", query: "%#{query}%")
        }

  def member_events
    Event.for_members(users.ids)
  end
end
