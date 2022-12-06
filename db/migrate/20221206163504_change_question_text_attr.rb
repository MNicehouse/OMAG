class ChangeQuestionTextAttr < ActiveRecord::Migration[7.0]
  def change
    change_column :questions, :question_text, :string
  end
end
