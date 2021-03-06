# == Schema Information
#
# Table name: roles
#
#  id            :integer          not null, primary key
#  name          :string
#  resource_id   :integer
#  resource_type :string
#  created_at    :datetime
#  updated_at    :datetime
#
# Indexes
#
#  index_roles_on_name                                    (name)
#  index_roles_on_name_and_resource_type_and_resource_id  (name,resource_type,resource_id)
#

FactoryBot.define do
  factory :role do
    name { 'mentor' }

    trait :curator do
      name { 'curator' }
    end

    trait :admin do
      name { 'admin' }
    end
  end
end
