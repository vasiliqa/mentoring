class AddFieldsToChildren < ActiveRecord::Migration[4.2]
  def change
    add_column :children, :description, :text
    add_column :children, :is_friendly, :boolean, default: false
  end
end
