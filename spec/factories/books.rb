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
#  file_file_size    :integer
#  file_updated_at   :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_books_on_owner_id  (owner_id)
#

FactoryBot.define do
  factory :book do
    name { '1984' }
    priority { 1 }
    owner_id { 1 }
    file { File.open("#{Rails.root}/public/robots.txt") }
  end
end
