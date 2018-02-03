# == Schema Information
#
# Table name: orphanages
#
#  id         :integer          not null, primary key
#  name       :string
#  address    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Orphanage < ApplicationRecord
  has_many :children, dependent: :destroy
  has_many :users, dependent: :nullify

  validates :name, presence: true, uniqueness: true
end
