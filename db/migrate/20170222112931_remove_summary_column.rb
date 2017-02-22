class RemoveSummaryColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column :reports, :summary
  end
end
