class DatePicker
  class << self

    def calc_to_and_from_dates( tDate: nil, fDate: nil, fDate_default: nil )
      tDate = 0.days.ago if tDate.nil?
      if fDate.nil?
        fDate = fDate_default.nil? ? ( tDate - 30.days ) : fDate_default
      end

      {
        tDate: to_dateTime( tDate ),
        fDate: from_dateTime( tDate:tDate, fDate:fDate )
      }
    end

    def to_dateTime( tDate )
      tDate.end_of_day.to_time
    end

    def from_dateTime( tDate:, fDate: )
      if fDate > tDate
        ( tDate - 1.day ).beginning_of_day.to_time
      else
        fDate.beginning_of_day.to_time
      end
    end

    def s_to_date( string='' )
      string.blank? ? nil : DateTime.parse( string )
    end

  end
end