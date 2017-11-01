class RemovePhotoFromChildren < ActiveRecord::Migration[4.2]
  def change
    remove_foreign_key :children, :photo
    remove_reference :children, :photo, index: true
  end
end
