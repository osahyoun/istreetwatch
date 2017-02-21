class ChangeTypeIncidentToArray < ActiveRecord::Migration[5.0]
  def change
    add_column :reports, :temp, :string, array: true
    Report.where.not( type_incident: nil ).each do |report|
      report.update( temp: [report.type_incident] )
    end
    remove_column :reports, :type_incident
    rename_column :reports, :temp, :type_incident
  end
end
