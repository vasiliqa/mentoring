class AddInstitutionToCandidateEducations < ActiveRecord::Migration[4.2]
  def change
    add_column :candidate_educations, :institution, :string
  end
end
