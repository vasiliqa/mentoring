# == Schema Information
#
# Table name: orphanages
#
#  id         :integer          not null, primary key
#  name       :string
#  address    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  curator_id :bigint(8)
#
# Indexes
#
#  index_orphanages_on_curator_id  (curator_id)
#

class Orphanage < ApplicationRecord
  has_many :children, dependent: :destroy
  has_many :users, dependent: :nullify
  belongs_to :curator, class_name: 'User', optional: true

  validates :name, presence: true, uniqueness: true
end
