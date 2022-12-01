class ChangeCompletedToResponses < ActiveRecord::Migration[7.0]
  def change
    change_column :responses, :completed, :boolean, default: true, null: false
  end
end
