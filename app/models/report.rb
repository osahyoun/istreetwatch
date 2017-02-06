class Report < ApplicationRecord
  validates(
    :informant_name, :informant_email, :informant_role,
    :type_incident, :description, :date,
    :town, :type_location,
    :reported_to_police, presence: true
  )
  validates :type_incident_other, presence: true, if: :type_incident_other?
  validates :type_location_other, presence: true, if: :type_location_other?

  scope :approved, -> { where(approved: true ) }

  def type_incident_other?
    type_incident.downcase.strip == 'other'
  end

  def type_location_other?
    type_location.downcase.strip == 'other'
  end

  class << self
    def latest
      where(approved: true).
      order('date desc').
      all()
    end

    def latest_for_map
      latest.where.not(lat: nil)
    end
  end
end
