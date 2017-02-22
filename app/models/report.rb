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
  validates :type_incident_other, presence: true, if: lambda { |report| report.is_other?( report.type_incident ) }
  validates :type_location_other, presence: true, if: lambda { |report| report.is_other?( report.type_location ) }

  scope :approved, -> { where(approved: true ) }
  scope :date_desc, -> { order( 'date desc' ) }

  before_save :check_lat_lng
  before_save :set_approved_at, if: :approved_changed?

  def is_other?( type )
    if type.is_a?( Array )
      type.map { |item| item&.downcase&.strip }.include?( 'other' )
    else
      type&.downcase&.strip == 'other'
    end
  end

  def type_incident_to_string
    type_incident&.join( ', ' )
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

    def to_csv( reports )
      CSV.generate do |csv|
        column_names = [
          'informant_name', 'informant_email', 'informant_tel', 'informant_role', 'informant_permission',
          'date', 'type_incident', 'type_incident_other', 'description', 'support',
          'house', 'street', 'town', 'region', 'postcode', 'country', 'type_location', 'type_location_other',
          'reported_to_police', 'approved',
          'created_at', 'updated_at', 'approved_at'
        ]
        csv << column_names
        reports.all.each do |report|
          csv << report.attributes.values_at(*column_names)
        end
      end
    end

    def q_public( q )
      q.blank? ? __elasticsearch__.search( Search.public_query_no_q ) :
        __elasticsearch__.search( Search.public_query_with_q( q ) )
    end

    def q_admin( q:q, fDate:Report.date_desc.last.date, tDate:Time.now, approved_only:false )
      fDate = Report.date_desc.last.date if fDate.blank?
      tDate = Time.now if tDate.blank?

      q.blank? ? __elasticsearch__.search( Search.admin_query_no_q( fDate:fDate, tDate:tDate, approved_only:approved_only ) ) :
        __elasticsearch__.search( Search.admin_query_with_q( q:q, fDate:fDate, tDate:tDate, approved_only:approved_only ) )
    end

    def reindex_elasticsearch
      __elasticsearch__.create_index! force: true
      __elasticsearch__.refresh_index!
      import
    end
  end

end
