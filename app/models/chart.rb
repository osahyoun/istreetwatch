class Chart
  FROM_DATE = 30.days.ago
  TO_DATE = 0.days.ago

  def initialize( fDate:, tDate: )
    @fDate = ( fDate.blank? ? FROM_DATE : DateTime.parse(fDate) ).beginning_of_day.to_time
    @tDate = ( tDate.blank? ? TO_DATE : DateTime.parse(tDate) ).end_of_day.to_time
    @unit = set_time_unit
  end

  def get_time_unit
    @unit
  end

  def incident_count_over_time
    Report.approved.
      send( "group_by_#{@unit}", :date, range: @fDate..@tDate ).
      count.
      reduce( {} ) { |acc, (date,v) | acc[date.iso8601] = v; acc }
  end

  private
    def data_between_dates
      Report.approved.where( date: @fDate..@tDate )
    end

    def set_time_unit
      time =  @tDate - @fDate
      if time < 61.days
        'day'
      elsif time >= 61.day && time < 30.months
        'month'
      else
        'year'
      end
    end
end
