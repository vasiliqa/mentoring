# == Schema Information
#
# Table name: children
#
#  id                  :integer          not null, primary key
#  first_name          :string
#  last_name           :string
#  middle_name         :string
#  birthdate           :date
#  orphanage_id        :integer
#  mentor_id           :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  description         :text
#  avatar_file_name    :string
#  avatar_content_type :string
#  avatar_file_size    :bigint(8)
#  avatar_updated_at   :datetime
#
# Indexes
#
#  index_children_on_orphanage_id  (orphanage_id)
#

class Child < ApplicationRecord
  belongs_to :orphanage
  belongs_to :mentor, foreign_key: :mentor_id, class_name: 'User', optional: true
  has_many :meetings

  has_attached_file :avatar
  validates_attachment_size :avatar, less_than: 1.megabytes
  validates_attachment_content_type :avatar, content_type: %w(image/jpeg image/jpg image/png image/gif)

  validates :first_name, :last_name, :birthdate, presence: true

  def name
    first_name
  end

  def full_name
    "#{last_name} #{first_name} #{middle_name}"
  end
end
