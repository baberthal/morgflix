class SeriesInfoWorker
  include Sidekiq::Worker

  def perform(external_id, options = {})
    series = Series.find_by(external_id: external_id)
    series.worker_task(options)
  end
end
