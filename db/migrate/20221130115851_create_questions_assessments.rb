class CreateQuestionsAssessments < ActiveRecord::Migration[7.0]
  def change
    create_table :questions_assessments do |t|
      t.integer :weight
      t.references :assessment, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.timestamps
    end
  end
end
