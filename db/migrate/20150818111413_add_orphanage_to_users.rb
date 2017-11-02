class AddOrphanageToUsers < ActiveRecord::Migration[4.2]
  def change
    add_reference :users, :orphanage, index: true
    add_foreign_key :users, :orphanages
  end
end
