class AddForigenKeyToUsers < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :lab_reports, :users
  end
end
