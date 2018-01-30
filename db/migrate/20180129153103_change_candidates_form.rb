class ChangeCandidatesForm < ActiveRecord::Migration[5.1]
  def change
    remove_column :candidates, :work_functions, :text
    remove_column :candidates, :work_schedule, :string
    remove_column :candidates, :visit_frequency, :string
    remove_column :candidates, :program_reason, :text
    remove_column :candidates, :person_character, :text
    remove_column :candidates, :person_information, :text
    remove_column :candidates, :help_reason, :text
    remove_column :candidates, :child_character, :text

    add_column :candidates, :family_attitude, :text
    add_column :candidates, :visit_hours, :text
    add_column :candidates, :want_new, :integer
    add_column :candidates, :plan_be_adoptive_parent, :integer
    add_column :candidates, :want_be_significant, :integer
    add_column :candidates, :want_get_experience, :integer
    add_column :candidates, :want_more_kids, :integer
    add_column :candidates, :want_be_in_team, :integer
    add_column :candidates, :want_change_job, :integer
    add_column :candidates, :pity_kids, :integer
    add_column :candidates, :want_pass_experience, :integer
    add_column :candidates, :maternal_instinct, :integer
    add_column :candidates, :want_increase_status, :integer
    add_column :candidates, :foreign_child, :text
    add_column :candidates, :unsolvable_problems, :text
    add_column :candidates, :tragic_events, :text
    add_column :candidates, :child_emotions, :text
    add_column :candidates, :life_changes, :text
    add_column :candidates, :week_visits, :boolean
    add_column :candidates, :monthly_meeting, :boolean

    change_column :candidates, :invalid_child, :text

    drop_table "candidate_children_experiences", id: :serial, force: :cascade do |t|
      t.integer "candidate_id", index: true
      t.string "organization_name"
      t.string "organization_contacts"
      t.string "position"
      t.text "functions"
      t.string "children_age"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
