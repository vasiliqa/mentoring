# == Schema Information
#
# Table name: reports
#
#  id                :integer          not null, primary key
#  aim               :text
#  state             :string
#  meeting_id        :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  duration          :integer
#  short_description :text
#  result            :text
#  feelings          :text
#  questions         :text
#  next_aim          :text
#  other_comments    :text
#

class Report < ApplicationRecord
  belongs_to :meeting
  has_many :activities, as: :trackable, class_name: 'PublicActivity::Activity', dependent: :destroy

  include AASM
  include PublicActivity::Model
  tracked only: [:create], owner: -> (controller, model) { model.meeting.mentor }

  validates :duration, :aim, :short_description, :result, :feelings, :questions, :next_aim, :other_comments, presence: true

  after_create do
    meeting.send_report!
  end

  aasm column: :state, whiny_transitions: false do
    state :new, initial: true
    state :rejected
    state :approved

    event :reject do
      after do
        meeting.reject_report
        meeting.save

        create_activity :reject, owner: meeting.mentor.curator
      end

      transitions from: :new, to: :rejected
    end

    event :resend do
      after do
        meeting.send_report
        meeting.save

        create_activity :resend, owner: meeting.mentor
      end

      transitions from: :rejected, to: :new
    end

    event :approve do
      after do
        meeting.approve_report
        meeting.save

        create_activity :approve, owner: meeting.mentor.curator
      end

      transitions from: :new, to: :approved
    end
  end

end
