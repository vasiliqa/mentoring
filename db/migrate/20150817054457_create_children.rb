class CreateChildren < ActiveRecord::Migration[4.2]
  def change
    create_table :children do |t|
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.date :birthdate
      t.references :orphanage, index: true
      t.integer :mentor_id

      t.timestamps null: false
    end
    add_foreign_key :children, :orphanages
  end
end
