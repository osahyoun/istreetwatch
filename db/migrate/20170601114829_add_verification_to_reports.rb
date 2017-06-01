class AddVerificationToReports < ActiveRecord::Migration[5.0]
  def change
    add_column :reports, :verification_code, :string
    add_column :reports, :verified_at, :datetime
  end
end
