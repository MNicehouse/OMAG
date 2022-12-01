class DeleteConsultantFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :consultant
  end
end
