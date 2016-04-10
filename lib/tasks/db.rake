namespace :db do
  
  task sidekiq_reset: :environment do
    Sidekiq::Queue.new.clear
    Sidekiq::RetrySet.new.clear
    Sidekiq::ScheduledSet.new.clear
  end

  task redis_reset: :environment do 
    $redis.flushall
  end

end