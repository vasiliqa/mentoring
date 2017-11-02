# == Schema Information
#
# Table name: candidate_family_members
#
#  id           :integer          not null, primary key
#  candidate_id :integer
#  name         :string
#  gender       :string
#  age          :string
#  relation     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_candidate_family_members_on_candidate_id  (candidate_id)
#

class CandidateFamilyMember < ApplicationRecord
  belongs_to :candidate
end
