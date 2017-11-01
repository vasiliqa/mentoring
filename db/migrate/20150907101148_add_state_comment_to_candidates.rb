class AddStateCommentToCandidates < ActiveRecord::Migration[4.2]
  def change
    add_column :candidates, :state_comment, :text
  end
end
