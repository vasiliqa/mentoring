# == Schema Information
#
# Table name: reports
#
#  id                   :integer          not null, primary key
#  state                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  feelings             :text
#  mentor_id            :integer
#  visits_count         :integer
#  description          :text
#  difficulties         :integer
#  difficulties_comment :text
#  need_help            :integer
#  questions            :integer
#  questions_comment    :text
#  share_permission     :boolean
#
# Indexes
#
#  index_reports_on_mentor_id  (mentor_id)
#

FactoryBot.define do
  factory :report do
    feelings 'feelings'
    visits_count 1
    description 'description'
    difficulties 1
    difficulties_comment 'comment'
    need_help 1
    questions 1
    questions_comment 'comment'
    share_permission true
    mentor_id 1
  end
end
