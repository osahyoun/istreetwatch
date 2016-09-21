require 'elasticsearch/model'

class Report < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  validates :description, :time, :town, presence: true

  scope :approved, -> { where(approved: true ) }

  class << self
    def latest
      where(approved: true).
      order('created_at desc').
      all()
    end

    def latest_for_map
      latest.where.not(lat: nil)
    end
  end
end
