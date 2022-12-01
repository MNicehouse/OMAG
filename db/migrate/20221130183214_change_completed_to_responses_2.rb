class ChangeCompletedToResponses2 < ActiveRecord::Migration[7.0]
  def change
    change_column :responses, :completed, :boolean, default: false, null: false
  end
end
