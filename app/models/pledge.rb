class Pledge < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, format: /@/, uniqueness: true

  def self.counter
    REDIS.get("pledges:counter")
  end

  def self.to_csv( pledges )
    CSV.generate do |csv|
      column_names = [ 'name', 'email' ]
      csv << column_names
      pledges.each do |pledge|
        csv << pledge.attributes.values_at(*column_names)
      end
    end
  end

end
