class ChangeGradeToLabReports < ActiveRecord::Migration[6.1]
  def change
    change_column :lab_reports, :grade, :string
  end
end
