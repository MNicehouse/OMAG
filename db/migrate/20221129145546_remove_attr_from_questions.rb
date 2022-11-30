class RemoveAttrFromQuestions < ActiveRecord::Migration[7.0]
  def change
    remove_column :questions, :weight
    remove_column :questions, :assessment_id
  end
end
