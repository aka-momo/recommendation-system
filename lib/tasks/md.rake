namespace :md do
  
  task start: :environment do
  	puts "Starting Sidekiq ..."
  	system("")
  	puts("-"*50)
  	puts "Starting Unicorn ..."
  	system("bundle exec unicorn_rails -c config/unicorn.rb -E production -D")
  	puts("-"*50)
    RecWorker.perform_async
  end

  task stop: :environment do 
    
  end

  task start_rec: :environment do 
  	RecWorker.perform_async
  end

end