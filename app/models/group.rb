# == Schema Information
#
# Table name: groups
#
#  id            :bigint           not null, primary key
#  description   :text
#  members_count :integer          default(0)
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Group < ApplicationRecord
  has_many :memberships, dependent: :destroy

  validates :name, presence: true
  
end
