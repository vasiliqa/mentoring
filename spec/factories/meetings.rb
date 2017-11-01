# == Schema Information
#
# Table name: meetings
#
#  id         :integer          not null, primary key
#  date       :datetime
#  state      :string
#  child_id   :integer
#  mentor_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_meetings_on_child_id  (child_id)
#

FactoryBot.define do
  factory :meeting do
    date 1.day.since
    state 'new'
    child_id 1
    mentor_id 2
  end

end
