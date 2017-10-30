class RemoveUnusedCandidateFields < ActiveRecord::Migration[5.1]
  def change
    remove_column :candidates, :work_start_date, :date
    remove_column :candidates, :work_end_date, :date
    remove_column :candidates, :house_type, :string
    remove_column :candidates, :number_of_rooms, :string
    remove_column :candidates, :peoples_for_room, :string
    remove_column :candidates, :peoples, :text
    remove_column :candidates, :pets, :string
    remove_column :candidate_educations, :start_date, :date
    remove_column :candidate_educations, :end_date, :date
  end
end
