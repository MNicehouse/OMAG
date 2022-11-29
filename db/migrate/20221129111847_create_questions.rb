class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.text :question_text
      t.string :question_type
      t.integer :weight
      t.references :assessment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
