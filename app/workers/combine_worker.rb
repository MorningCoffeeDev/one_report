class CombineWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(combine_id)
    @combine = Combine.find(combine_id)
    @combine.merged_pdf
  end

end
