class Pledge < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, format: /@/, uniqueness: true

  def self.counter
    REDIS.get("pledges:counter")
  end
end
