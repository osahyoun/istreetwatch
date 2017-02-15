class Search
  class << self

    def public_query_with_q( q )
      sort = is_search_phrase(q) ? [ '_score', { date: 'desc' } ] : { date: 'desc' }

      {
        query: {
          bool: {
            must: public_multi_match( q ),
            filter: public_filter
          }
        },
        sort: sort
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

    def admin_query_with_q( q, fDate, tDate)
      sort = is_search_phrase(q) ? [ '_score', { date: 'desc' } ] : { date: 'desc' }

      {
        query: {
          bool: {
            must: admin_multi_match( q ),
            filter: admin_filter( fDate, tDate )
          }
        },
        sort: sort
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

    private
      def is_search_phrase( q )
        q.split(' ').length > 1 ? true : false
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
        {
          range: { date: { gte: fDate, lte: tDate } }
        }
      end
  end
end