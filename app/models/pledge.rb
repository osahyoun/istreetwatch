class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end

class Pledge < ApplicationRecord
  validates :email, presence: true, email: true
  validates :email, uniqueness: true

  def self.counter
    REDIS.get("pledges:counter")
  end
end
