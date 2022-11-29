class AddConsultantToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :consultant, :boolean
  end
end
