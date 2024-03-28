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
#
class Group < ApplicationRecord
  has_many :memberships, dependent: :destroy

  validates :name, presence: true

  scope :search, ->(query) {
    where("LOWER(name) LIKE LOWER(:query) OR LOWER(description) LIKE LOWER(:query)", query: "%#{query}%")
  }
  
end
