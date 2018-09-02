class ChangeReports < ActiveRecord::Migration[5.1]
  def change
    Report.destroy_all
    Meeting.update_all(state: :new)
    remove_reference :reports, :meeting, index: true, foreign_key: true
    remove_column :reports, :duration, :integer
    remove_column :reports, :aim, :text
    remove_column :reports, :short_description, :text
    remove_column :reports, :result, :text
    remove_column :reports, :questions, :text
    remove_column :reports, :next_aim, :text
    remove_column :reports, :other_comments, :text
    add_reference :reports, :mentor, index: true, foreign_key: { to_table: :users }
    add_column :reports, :visits_count, :integer
    add_column :reports, :description, :text
    add_column :reports, :difficulties, :integer
    add_column :reports, :difficulties_comment, :text
    add_column :reports, :need_help, :integer
    add_column :reports, :questions, :integer
    add_column :reports, :questions_comment, :text
    add_column :reports, :share_permission, :boolean
  end
end
