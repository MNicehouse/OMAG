class RemoveColumnsFromQuestions < ActiveRecord::Migration[7.0]
  def change
    remove_column :questions, :weight
    remove_reference :questions, :assessment, index: true, foreign_key: true
  end
end
