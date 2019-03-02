# == Schema Information
#
# Table name: photos
#
#  id                 :integer          not null, primary key
#  description        :text
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :bigint(8)
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

FactoryBot.define do
  factory :photo do
    description { "MyText" }
    image { Rack::Test::UploadedFile.new("#{Rails.root}/app/assets/images/image.png", 'image/png') }
    album { nil }
    user { User.first }
  end
end
