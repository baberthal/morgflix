module Scrapable
  extend ActiveSupport::Concern

  def fetch_info(options = {})
    info = SeriesSearcher.new.info(name, options)
    info.transform_keys! { |k| k.snakeify.to_sym }
    updated = self.attributes.select { |_, v| v.nil? }.symbolize_keys

    updated.each_key { |k| updated[k] = info.fetch(_key_for(k)) }

    update!(updated)
  end

  private

  def _key_crosswalk
    {
      external_id: :seriesid,
      name: :series_name,
      banner_info: :banner
    }
  end

  def _key_for(key_name)
    _key_crosswalk[key_name.to_sym] || key_name.to_sym
  end
end
