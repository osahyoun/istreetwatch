require 'elasticsearch/model'

class Report < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  validates(
    :informant_name, :informant_email, :informant_role,
    :type_incident, :description, :support, :date,
    :town, :type_location,
    :reported_to_police, presence: true
  )
  validate :date_cannot_be_in_the_future
  validates :type_incident_other, presence: true, if: :type_incident_other?
  validates :type_location_other, presence: true, if: :type_location_other?

  scope :approved, -> { where(approved: true ) }
  scope :date_desc, -> { order( 'date desc' ) }

  before_save :check_lat_lng
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

    def date_cannot_be_in_the_future
      if date.present? && date > Time.zone.now
        errors.add(:date, "can't be in the future")
      end
    end

    def check_lat_lng
      while with_duplicate_position_count > 0
        self.lat = lat + (rand - 0.5) / 1500
        self.lng = lng + (rand - 0.5) / 1500
      end
    end

    def with_duplicate_position_count
      Report.where(lat: lat, lng: lng)
        .where.not(lat: nil, lng: nil)
        .where.not(id: id)
        .count
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

    def q_public( q )
      q.blank? ? __elasticsearch__.search( Search.public_query_no_q ) :
        __elasticsearch__.search( Search.public_query_with_q( q ) )
    end

    def q_admin( q, fDate=Report.date_desc.last.date, tDate=Time.now )
      fDate = Report.date_desc.last.date if fDate.blank?
      tDate = Time.now if tDate.blank?

      q.blank? ? __elasticsearch__.search( Search.admin_query_no_q( fDate, tDate ) ) :
        __elasticsearch__.search( Search.admin_query_with_q( q, fDate, tDate ) )
    end
  end

end
