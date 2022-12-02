class ChangeOptionTextType < ActiveRecord::Migration[7.0]
  def change
    change_column :options, :option_text, :string
  end
end
