class AddStateToAssessments < ActiveRecord::Migration[7.0]
  def change
    add_column :assessments, :state, :string
  end
end
