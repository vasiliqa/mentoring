# This migration comes from forem (originally 20140917034000)
class AddPositionToCategories < ActiveRecord::Migration[4.2]
  def change
    add_column :forem_categories, :position, :integer, :default => 0
  end
end
