class RecWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { daily }

  # Perform Caching of recommendations
  def perform
    RecommenderBase.prepare_svd
  end
end