class ChageAssessmentStateType < ActiveRecord::Migration[7.0]
  def change
        remove_column :assessments, :state
        add_column :assessments, :state, :boolean, default: false, null: false
  end
end
