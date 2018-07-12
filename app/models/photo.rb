# == Schema Information
#
# Table name: photos
#
#  id                 :integer          not null, primary key
#  description        :text
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  album_id           :integer
#  user_id            :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_photos_on_album_id  (album_id)
#  index_photos_on_user_id   (user_id)
#

class Photo < ApplicationRecord
  include PublicActivity::Model
  tracked only: [:create], owner: :user

  belongs_to :album
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :activities, as: :trackable, class_name: 'PublicActivity::Activity', dependent: :destroy

  has_attached_file :image
  validates_attachment_presence :image
  validates_attachment_size :image, less_than: 16.megabytes
  validates_attachment_content_type :image, content_type: %w(image/jpeg image/jpg image/png image/gif image/bmp)

  scope :persisted, -> { where 'id IS NOT NULL' }
end
