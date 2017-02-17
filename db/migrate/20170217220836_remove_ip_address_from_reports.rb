class RemoveIpAddressFromReports < ActiveRecord::Migration[5.0]
  def change
    remove_column :reports, :ip_address, :string
  end
end
