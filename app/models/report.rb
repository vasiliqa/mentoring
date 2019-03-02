# == Schema Information
#
# Table name: reports
#
#  id                   :integer          not null, primary key
#  state                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  feelings             :text
#  mentor_id            :bigint(8)
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

class Report < ApplicationRecord
  include AASM
  include PublicActivity::Model
  tracked only: [:create], owner: -> (controller, model) { model.mentor }

  belongs_to :mentor, class_name: 'User'
  has_many :activities, as: :trackable, class_name: 'PublicActivity::Activity', dependent: :destroy

  validates :description, presence: true
  validates :visits_count, numericality: { greater_than_or_equal_to: 0, only_integer: true}
  validates :difficulties, :questions, inclusion: { in: [0, 1] }, allow_nil: true
  validates :need_help, inclusion: { in: [0, 1, 2] }, allow_nil: true
  validates :difficulties_comment, presence: true, if: Proc.new { |r| r.difficulties == 1 }
  validates :questions_comment, presence: true, if: Proc.new { |r| r.questions == 1 }
  validates :share_permission, inclusion: { in: [true, false] }

  aasm column: :state, whiny_transitions: false do
    state :new, initial: true
    state :rejected
    state :approved

    event :reject do
      after do
        create_activity :reject, owner: mentor.curator
      end

      transitions from: :new, to: :rejected
    end

    event :resend do
      after do
        create_activity :resend, owner: mentor
      end

      transitions from: :rejected, to: :new
    end

    event :approve do
      after do
        create_activity :approve, owner: mentor.curator
      end

      transitions from: :new, to: :approved
    end
  end
end
