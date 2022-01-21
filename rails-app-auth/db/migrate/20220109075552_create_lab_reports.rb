class CreateLabReports < ActiveRecord::Migration[6.1]
  def change
    create_table :lab_reports do |t|
      t.string :title
      t.text :description
      t.integer :grade

      t.timestamps
    end
  end
end
