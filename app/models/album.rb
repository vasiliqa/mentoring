# == Schema Information
#
# Table name: albums
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_albums_on_user_id  (user_id)
#

class Album < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy

  validates :title, presence: true
end
