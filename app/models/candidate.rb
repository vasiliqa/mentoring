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

class Candidate < ApplicationRecord
  include AASM

  has_many :candidate_educations, dependent: :destroy, inverse_of: :candidate
  has_many :candidate_family_members, dependent: :destroy, inverse_of: :candidate
  accepts_nested_attributes_for :candidate_educations
  accepts_nested_attributes_for :candidate_family_members

  validates_presence_of :first_name, :last_name, :middle_name, :registration_address, :home_address,
                        :phone_number, :email, :birth_date, :confession, :health_status,
                        :serious_diseases, :organization_name, :work_contacts, :work_position,
                        :visit_hours, :hobby, :martial_status, :family_attitude, :program_role,
                        :child_age, :child_gender, :invalid_child, :foreign_child, :unsolvable_problems,
                        :tragic_events, :child_emotions, :life_changes, :alcohol, :tobacco, :psychoactive,
                        :drugs, :child_crime, :disabled_parental_rights, :info_about_program


  validates :week_visits, :monthly_meeting, :reports, :photo_rights, :russian_citizenship,
            inclusion: { in: [true, false] }
  validates :want_new, :plan_be_adoptive_parent, :want_be_significant, :want_get_experience,
            :want_more_kids, :want_be_in_team, :want_change_job, :pity_kids, :want_pass_experience,
            :maternal_instinct, :want_increase_status, inclusion: { in: [1, 2, 3, 4, 5] }

  validates :email, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\W]+\z/ }, uniqueness: { case_sensitive: false }

  HEALTH_STATUSES = ['отлично', 'хорошо', 'средне', 'плохо']
  GENDERS = ['Мужской', 'Женский']
  CHILD_GENDERS = ['Мужской', 'Женский', 'Не имеет значения']
  EDUCATION_TYPES = ['Общеобразовательная школа', 'Университет, Институт, техникум', 'Дополнительные курсы, тренинги, семинары']
  MARTIAL_STATUSES = ['Женат (замужем)', 'Гражданский брак', 'Разведён (разведена)', 'Вдовец (вдова)', 'Не женат (не замужем)']
  PROGRAM_ROLES = ['Наставника', 'Репетитора', 'Партнёра (оказывать единоразовую/постоянную финансовую поддержку)']

  aasm column: :state, whiny_transitions: false do
    state :new, initial: true
    state :approved

    event :approve do
      after do
        generated_password = Devise.friendly_token.first(8)
        user = User.create(email: email, first_name: first_name, last_name: last_name, middle_name: middle_name, password: generated_password)
        user.add_role :mentor
        RegistrationMailer.welcome(user, generated_password).deliver_now
      end
      transitions from: :new, to: :approved
    end
  end

  def full_name
    "#{last_name} #{first_name} #{middle_name}"
  end
end
