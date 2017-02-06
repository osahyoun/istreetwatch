class AddApprovedAtToReports < ActiveRecord::Migration[5.0]
  def change
    add_column :reports, :approved_at, :time
  end
end
