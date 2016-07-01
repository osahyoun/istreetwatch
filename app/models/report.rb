class Report < ApplicationRecord
  validates :description, :time, :town, presence: true

  class << self
    def latest
      where(approved: true).
      order('time desc').
      limit(200)
    end

    def latest_for_map
      latest.where.not(lat: nil)
    end
  end
end
