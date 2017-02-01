class AddFieldsToReports < ActiveRecord::Migration[5.0]
  def change
    add_column :reports, :informant_tel, :string
    add_column :reports, :informant_permission, :boolean
    add_column :reports, :informant_role, :string
    add_column :reports, :type_incident, :string
    add_column :reports, :type_incident_other, :string
    add_column :reports, :type_location, :string
    add_column :reports, :type_location_other, :string
    add_column :reports, :reported_to_police, :string
    rename_column :reports, :name, :informant_name
    rename_column :reports, :email, :informant_email
    rename_column :reports, :time, :date
  end
end
