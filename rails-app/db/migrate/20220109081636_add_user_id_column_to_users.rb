class AddUserIdColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :lab_reports, :user_id, :integer
  end
end
