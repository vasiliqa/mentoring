# == Schema Information
#
# Table name: candidate_children_experiences
#
#  id                    :integer          not null, primary key
#  candidate_id          :integer
#  organization_name     :string
#  organization_contacts :string
#  position              :string
#  functions             :text
#  children_age          :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
# Indexes
#
#  index_candidate_children_experiences_on_candidate_id  (candidate_id)
#

class CandidateChildrenExperience < ApplicationRecord
  belongs_to :candidate
end
