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

FactoryBot.define do
  factory :album do
    title "MyString"
    description "MyText"
    user User.first
  end

end
