class AddRussianCitizenshipToCandidates < ActiveRecord::Migration[4.2]
  def change
    add_column :candidates, :russian_citizenship, :boolean
    remove_column :candidates, :nationality, :string
  end
end
