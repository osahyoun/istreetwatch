Rails.application.config.after_initialize do
  ActiveRecord::Base.connection_pool.disconnect!

  ActiveSupport.on_load(:active_record) do
    if !ENV['DATABASE_URL']
      config = Rails.application.config.database_configuration[Rails.env]
      config['reaping_frequency'] = ENV['DB_REAP_FREQ'] || 10 # seconds
      config['pool'] = ENV['DB_POOL'] || 5
      ActiveRecord::Base.establish_connection(config)
    else
      ActiveRecord::Base.establish_connection
    end
  end
end