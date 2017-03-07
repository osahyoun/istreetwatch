class AddSourceToReports < ActiveRecord::Migration[5.0]
  def change
    add_column :reports, :source, :string
  end
end
