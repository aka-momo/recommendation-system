
redis_conf = {
  host: "127.0.0.1",
  port: 6379
}

$redis = Redis.new(:host => redis_conf[:host], :port => redis_conf[:port], :db => 15)

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{redis_conf[:host]}:#{redis_conf[:port]}"}
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{redis_conf[:host]}:#{redis_conf[:port]}"}
end

Sidetiq.configure do |config|
  # Clock resolution in seconds (default: 1).
  config.resolution = 1

  # Clock locking key expiration in ms (default: 1000).
  config.lock_expire = 100

  # When `true` uses UTC instead of local times (default: false).
  config.utc = true

  # Scheduling handler pool size (default: number of CPUs as
  # determined by Celluloid).
  #config.handler_pool_size = 5

  # History stored for each worker (default: 50).
  config.worker_history = 50
end

RecWorker.perform_async