class BannerWorker
  include Sidekiq::Worker
  def perform(banner_id)
    banner = Banner.find_by(id: banner_id)
    TVDB::Banner.download(banner.banner_path)
  end
end
