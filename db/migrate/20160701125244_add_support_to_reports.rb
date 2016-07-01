class AddSupportToReports < ActiveRecord::Migration[5.0]
  def change
    add_column :reports, :support, :string
  end
end
