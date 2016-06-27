class Report < ApplicationRecord
  class << self
    def latest
      where(approved: false).
      where.not(lat: nil).
      order('created_at desc').
      limit(200)
    end
  end
end
