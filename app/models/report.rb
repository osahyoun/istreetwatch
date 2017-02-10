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

    def q_public( q )
      __elasticsearch__.search( q_public_query( q ) )
    end

    private
      def q_public_query( q )
        {
          query: {
            bool: {
              must: public_multi_match( q ),
              filter: {
                term: { approved: true }
              }
            }
          }
        }
      end

      def public_multi_match( q )
        {
          multi_match: {
            query: q,
            type: 'best_fields',
            fields: [
              :type_incident, :type_incident_other, :description, :support,
              :street, :town, :postcode, :region, :house, :country, :type_location, :type_location_other
            ]
          }
        }
      end
  end
end
