class AddInformantIsStudentToReports < ActiveRecord::Migration[5.0]
  def change
    add_column :reports, :informant_is_student, :boolean
  end
end
