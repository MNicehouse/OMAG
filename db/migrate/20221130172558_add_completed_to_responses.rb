class AddCompletedToResponses < ActiveRecord::Migration[7.0]
  def change
    add_column :responses, :completed, :boolean
  end
end
