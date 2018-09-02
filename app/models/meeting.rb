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

class Meeting < ApplicationRecord
  include AASM
  include PublicActivity::Model
  tracked only: [:create], owner: :mentor

  belongs_to :child
  belongs_to :mentor, foreign_key: :mentor_id, class_name: 'User'
  has_many :activities, as: :trackable, class_name: 'PublicActivity::Activity', dependent: :destroy

  validates :date, presence: true
  validate :date_in_future, on: :create
  def date_in_future
    errors.add(:base, 'Дата встречи не может быть в прошлом') if date.present? && date < Time.zone.now
  end

  aasm column: :state, whiny_transitions: false do
    state :new, initial: true
    state :rejected

    event :reject do
      before do
        create_activity :reject, owner: mentor.curator
      end

      transitions from: :new, to: :rejected
    end

    event :reopen do
      before do
        create_activity :reopen, owner: mentor
      end

      transitions from: :rejected, to: :new
    end
  end
end
