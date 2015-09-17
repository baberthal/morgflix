module Scrapable
  extend ActiveSupport::Concern

  included do
    after_create :info, if: :external_id?
  end

  class_methods do
    def search_tvdb(query, options = {})
      TVDB.series_search(query, options)
    end
    alias_method :search, :search_tvdb unless defined?(search) == 'method'
  end

  def info(options = {})
    SeriesInfoWorker.perform_async(external_id, options)
  end

  def worker_task(options = {})
    full, banners, actors = TVDB.series_by_id(external_id, options)
    update!(full.app_attributes)
    _create_banners(banners) unless banners.nil? || banners.empty?
    _create_actors(actors) unless actors.nil? || actors.empty?
  end

  private

  def _create_banners(banner_array)
    banner_array.each do |b|
      Banner.create!({
        series_id: id
      }.merge(b.app_attributes))
    end
  end

  def _create_actors(actor_array)
    actor_array.each do |a|
      Actor.create!({
        series_id: id
      }.merge(a.app_attributes))
    end
  end
end
