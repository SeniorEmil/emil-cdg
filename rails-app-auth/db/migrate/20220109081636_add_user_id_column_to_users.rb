class AddUserIdColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :lab_reports, :auth_user_id, :integer
  end
end
