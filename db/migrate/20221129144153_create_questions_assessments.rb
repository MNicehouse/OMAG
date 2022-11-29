class CreateQuestionsAssessments < ActiveRecord::Migration[7.0]
  def change
    create_table :questions_assessments do |t|
      t.integer :weight
      t.references :question
      t.references :assessment

      t.timestamps
    end
  end
end
