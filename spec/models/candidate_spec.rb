# == Schema Information
#
# Table name: candidates
#
#  id                       :integer          not null, primary key
#  last_name                :string
#  first_name               :string
#  middle_name              :string
#  registration_address     :string
#  home_address             :string
#  phone_number             :string
#  email                    :string
#  birth_date               :date
#  confession               :string
#  health_status            :string
#  serious_diseases         :string
#  organization_name        :string
#  work_contacts            :string
#  work_position            :string
#  hobby                    :text
#  martial_status           :string
#  program_role             :string
#  child_age                :string
#  child_gender             :string
#  invalid_child            :text
#  alcohol                  :string
#  tobacco                  :string
#  psychoactive             :string
#  drugs                    :string
#  child_crime              :string
#  disabled_parental_rights :string
#  reports                  :boolean
#  photo_rights             :boolean
#  info_about_program       :string
#  state                    :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  state_comment            :text
#  russian_citizenship      :boolean
#  family_attitude          :text
#  visit_hours              :text
#  want_new                 :integer
#  plan_be_adoptive_parent  :integer
#  want_be_significant      :integer
#  want_get_experience      :integer
#  want_more_kids           :integer
#  want_be_in_team          :integer
#  want_change_job          :integer
#  pity_kids                :integer
#  want_pass_experience     :integer
#  maternal_instinct        :integer
#  want_increase_status     :integer
#  foreign_child            :text
#  unsolvable_problems      :text
#  tragic_events            :text
#  child_emotions           :text
#  life_changes             :text
#  week_visits              :boolean
#  monthly_meeting          :boolean
#

require 'rails_helper'

RSpec.describe Candidate, type: :model do
  let(:candidate) { create :candidate, email: 'test_candidate_email@example.com' }
  let(:user) { create :user, email: "jojo@yahoo.com"}

  describe '#approve' do
    context 'when new candidate is approved' do
      subject do
        candidate.approve!
      end

      it { expect{subject}.to change{candidate.reload.state}.from('new').to('approved') }
      it { expect{subject}.to change(User, :count).by(1) }
    end
  end

  describe "Welcome Email" do
    include EmailSpec::Helpers
    include EmailSpec::Matchers
    include Rails.application.routes.url_helpers

    it "should be set to be delivered to the email passed in" do
      @email = RegistrationMailer.welcome(user, "test_password")
      expect(@email).to deliver_to("jojo@yahoo.com")
    end
  end

end
