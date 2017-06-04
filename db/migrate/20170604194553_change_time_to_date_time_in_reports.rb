class ChangeTimeToDateTimeInReports < ActiveRecord::Migration[5.0]
  def change
    remove_column :reports, :approved_at
    add_column :reports, :approved_at, :datetime
  end
end
