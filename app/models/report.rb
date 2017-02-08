class Report < ApplicationRecord
  validates(
    :informant_name, :informant_email, :informant_role,
    :type_incident, :description, :support, :date,
    :town, :type_location,
    :reported_to_police, presence: true
  )
  validates :type_incident_other, presence: true, if: :type_incident_other?
  validates :type_location_other, presence: true, if: :type_location_other?

  scope :approved, -> { where(approved: true ) }

  before_save :set_approved_at, if: :approved_changed?

  def type_incident_other?
    type_incident&.downcase&.strip == 'other'
  end

  def type_location_other?
    type_location&.downcase&.strip == 'other'
  end

  private
    def set_approved_at
      if approved && approved_at.nil?
        self.approved_at = Time.zone.now
      end
    end

  class << self
    def latest
      approved.
      order('date desc').
      all()
    end

    def latest_for_map
      latest.where.not(lat: nil)
    end
  end
end
