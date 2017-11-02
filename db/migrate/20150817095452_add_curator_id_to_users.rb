class AddCuratorIdToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :curator_id, :integer
  end
end
