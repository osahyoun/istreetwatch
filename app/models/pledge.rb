class Pledge < ActiveRecord::Base

  validates_presence_of :name, :email
  validates_format_of       :email,    :with => /\A[^@\s]+@[^@\s]+\.[^@\s]+\Z/i

  class << self
    def cached_count
      Pledge.all.count
    end
  end  

end