# sidekiq_config = { url: ENV['JOB_WORKER_URL'], namespace: 'sidekiq_job' }

# Sidekiq.configure_server do |config|
#   config.redis = sidekiq_config
# end

# Sidekiq.configure_client do |config|
#   config.redis = sidekiq_config
# end


sidekiq_config = { url: "redis://redis:6379/0", namespace: 'sidekiq_job' }

Sidekiq.configure_server do |config|
  config.redis = sidekiq_config
end

Sidekiq.configure_client do |config|
  config.redis = sidekiq_config
end
