class CreateOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :options do |t|
      t.text :option_text
      t.integer :value
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
