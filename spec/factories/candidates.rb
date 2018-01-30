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

FactoryBot.define do
  factory :candidate do
    last_name "Laden"
    first_name "Osama"
    middle_name "Bin"
    registration_address "Pakistan, Al'Kaida Street"
    home_address "Same as registration adress"
    phone_number "+71112223344"
    sequence(:email) {|n| "osama_#{n}@alkaida.com"}
    birth_date 50.years.ago
    russian_citizenship false
    confession "Islam"

    health_status "ok"
    serious_diseases "no"

    organization_name "Al'Kaida"
    work_contacts "911"
    work_position "Leader"
    visit_hours "9:00-18:00"

    hobby "Exploding"

    martial_status "married"
    family_attitude "great"

    program_role "Mentor"
    want_new 5
    plan_be_adoptive_parent 5
    want_be_significant 5
    want_get_experience 5
    want_more_kids 5
    want_be_in_team 5
    want_change_job 5
    pity_kids 5
    want_pass_experience 5
    maternal_instinct 5
    want_increase_status 5

    child_age "10"
    child_gender "M"
    invalid_child "Yes"
    foreign_child "Yes"
    unsolvable_problems "Yes"
    tragic_events "Yes"
    child_emotions "Yes"
    life_changes "Yes"

    week_visits true

    alcohol "yes, every day"
    tobacco "yes"
    psychoactive "yes, LSD-25, DMT, DOB, 2C-B etc"
    drugs "yes, heroin, cocain, methamphetamin etc"
    child_crime "no"
    disabled_parental_rights "no"

    monthly_meeting true
    reports true
    photo_rights true
    info_about_program "internet"
  end
end
