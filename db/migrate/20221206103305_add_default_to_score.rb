class AddDefaultToScore < ActiveRecord::Migration[7.0]
  def change
    change_column :responses, :score, :integer, default: 0
  end
end
