module Scrapable
  extend ActiveSupport::Concern

  included do
    include PrivateMethods
    after_create :info, if: :external_id?
  end

  class_methods do
    def search_tvdb(query, options = {})
      searcher = SeriesSearcher.new
      results = searcher.search(query, options)
      case results
      when Array
        _extract_hashes(results)
      when Hash
        _transform(results, base: true)
      end
    end
  end

  def search(options = {})
    result = singleton_class.send(:search_tvdb, name, options)
    _update(result)
  end

  def info(options = {})
    scraper = SeriesScraper.new(external_id)
    info = scraper.info(options)
    _transform(info, full: true)
    updated = _nil_attrs
    updated.each_key { |k| updated[k] = info[_key_for(k)] }
    updated
    # update!(updated)
  end

  module PrivateMethods
    def self.included(base)
      base.extend self
    end

    private

    def _update(updated_attrs)
      updated_attrs[:external_id] = updated_attrs.delete(:id).to_i
      # updated_attrs[:name] = updated_attrs.delete(:series_name)
      update!(updated_attrs)
    end

    def _nil_attrs
      attributes.select { |_, v| v.nil? }.symbolize_keys
    end

    def _extract_hashes(array)
      array.each do |entry|
        _transform(entry, base: true)
      end
    end

    def _transform(hash, opts = {})
      hash.transform_keys! do |k|
        k.to_s.snakeify.to_sym
      end
      if opts[:base]
        hash.select! { |k, _| _base_fields.include?(k) }
      elsif opts[:full]
        hash.select! { |k, _| _full_fields.include?(k) }
      end
    end

    def _base_fields
      [:id, :language, :network]
    end

    def _full_fields
      %i(overview first_aired airs_day_of_week airs_time content_rating imdb_id
         zap2it_id network_id rating rating_count runtime status added added_by
         lastupdated tms_wanted_old id language network)
    end

    def _key_crosswalk
      {
        external_id: :seriesid,
        name: :series_name,
        banner_info: :banner,
        air_day_of_week: :airs_day_of_week,
        air_time: :airs_time,
        tvdb_series_id: :series_id,
        tvdb_last_update: :lastupdated,
        tvdb_tms_wanted_old: :tms_wanted_old
      }
    end

    def _key_for(key_name)
      _key_crosswalk[key_name.to_sym] || key_name.to_sym
    end

    def _extract_banner_opts(opts)
      [opts[:banner], opts[:fanart], opts[:poster]]
    end

    def _extract_genres(text)
      text.split('|')
    end
  end
end
