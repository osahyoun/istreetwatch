class Pledge < ActiveRecord::Base

  validates_presence_of :name, :email

  class << self
    def cached_count
      Pledge.all.count
    end
  end  

end