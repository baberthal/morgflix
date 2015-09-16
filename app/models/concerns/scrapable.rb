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
    full, banners, actors = TVDB.series_by_id(external_id, options)
    update!(full.app_attributes)
    banners.each do |b|
      Banner.create!({
        series_id: Series.find_by(external_id: b.series_id).id
      }.merge(b.app_attributes))
    end unless banners.nil?
    actors.each do |a|
      Actor.create!({
        series_id: Series.find_by(external_id: a.series_id).id
      }.merge(a.app_attributes))
    end unless banners.nil?
    true
  end
end
