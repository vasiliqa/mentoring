class AddDescriptionToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :description, :text
    add_column :users, :display_on_site, :boolean, default: false
    remove_column :children, :is_friendly, :boolean, default: false
  end
end
