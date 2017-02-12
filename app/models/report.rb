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
  scope :date_desc, -> { order( 'date desc' ) }

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
      q.blank? ? __elasticsearch__.search( public_query_no_q ) :
        __elasticsearch__.search( public_query_with_q(q) )
    end

    def q_admin( q, fDate, tDate )
      q.blank? ? __elasticsearch__.search( admin_query_no_q( fDate, tDate ) ) :
        __elasticsearch__.search( admin_query_with_q( q, fDate, tDate ) )
    end

    private
      def public_query_with_q( q )
        {
          query: {
            bool: {
              must: public_multi_match( q ),
              filter: public_filter
            }
          },
          sort: [
            '_score',
            { date: 'desc' }
          ]
        }
      end

      def public_query_no_q
        {
          query: {
            bool: {
              must: public_filter
            }
          },
          sort: { date: 'desc' }
        }
      end

      def admin_query_with_q( q, fDate, tDate )
        {
          query: {
            bool: {
              must: admin_multi_match( q ),
              filter: admin_filter( fDate, tDate )
            }
          },
          sort: [
            '_score',
            { date: 'desc' }
          ]
        }
      end

      def admin_query_no_q( fDate, tDate )
        {
          query: {
            bool: {
              must: admin_filter( fDate, tDate )
            }
          },
          sort: { date: 'desc' }
        }
      end

      def public_multi_match( q )
        {
          multi_match: {
            query: q,
            type: 'best_fields',
            fields: [
              :type_incident, :type_incident_other, :description, :support,
              :street, :town, :postcode, :region, :country, :type_location, :type_location_other
            ]
          }
        }
      end

      def admin_multi_match( q )
        {
          multi_match: {
            query: q,
            type: 'best_fields',
            fields: [
              :informant_name, :informant_email, :informant_tel, :informant_role,
              :type_incident, :type_incident_other, :description, :support,
              :street, :town, :postcode, :region, :country, :type_location, :type_location_other, :_id
            ]
          }
        }
      end

      def public_filter
        {
          term: { approved: true }
        }
      end

      def admin_filter( fDate, tDate )
        fDate = Report.date_desc.last.date if fDate.blank?
        tDate = Time.now if tDate.blank?

        {
          range: { date: { gte: fDate, lte: tDate } }
        }
      end
  end
end
