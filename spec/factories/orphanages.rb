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

FactoryBot.define do
  factory :orphanage do
    name { "MyString" }
    address { "MyString" }
  end
end
