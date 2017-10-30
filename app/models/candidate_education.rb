# == Schema Information
#
# Table name: candidate_educations
#
#  id           :integer          not null, primary key
#  candidate_id :integer
#  education    :string
#  specialty    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  institution  :string
#
# Indexes
#
#  index_candidate_educations_on_candidate_id  (candidate_id)
#

class CandidateEducation < ApplicationRecord
  belongs_to :candidate
end
