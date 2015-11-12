class CombineWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(combine_id)
    combine = Combine.find_by_id(combine_id)
    combine.run if combine
  end
end
