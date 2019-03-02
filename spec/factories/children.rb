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

FactoryBot.define do
  factory :child do
    first_name { "Putin" }
    last_name { "VVP" }
    middle_name { "SVCH" }
    birthdate { 14.years.ago }
    orphanage
  end
end
