class Fragment < ActiveRecord::Base
  include IdentityCache
  cache_index :name, :unique => true

end