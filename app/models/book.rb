# == Schema Information
#
# Table name: books
#
#  id                :integer          not null, primary key
#  name              :string
#  priority          :integer          default("interesting")
#  owner_id          :integer
#  file_file_name    :string
#  file_content_type :string
#  file_file_size    :bigint(8)
#  file_updated_at   :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_books_on_owner_id  (owner_id)
#

class Book < ApplicationRecord
  include PublicActivity::Model
  tracked only: [:create], owner: :owner

  belongs_to :owner, foreign_key: :owner_id, class_name: 'User'
  has_many :comments, as: :commentable
  has_many :activities, as: :trackable, class_name: 'PublicActivity::Activity', dependent: :destroy

  enum priority: [ :immediately_read, :must_read, :interesting ]

  has_attached_file :file
  validates_attachment_size :file, less_than: 40.megabytes
  do_not_validate_attachment_file_type :file

  validates :name, presence: true
end
