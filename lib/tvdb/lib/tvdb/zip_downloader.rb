require 'fileutils'
require 'tmpdir'

module TVDB
  class ZipDownloader
    include Caching
    attr_accessor :language, :series_id, :tmp_dir
    attr_reader :uri, :tmp_file

    def self.download(series_id, options = {})
      new(series_id, options).response
    end

    def initialize(series_id, options = {})
      @series_id = series_id
      @uri = TVDB.zip_mirror
      @language = options.delete(:language) || options.delete(:lang)
      options[:tmp_dir] ||= Dir.tmpdir
      @tmp_dir = Pathname.new(options.delete(:tmp_dir))
      FileUtils.mkdir_p(@tmp_dir)
      @tmp_file = tmp_dir.join("series-info-#{series_id}-#{Time.now.to_i}")
    end

    def api_url
      "#{uri}/series/#{series_id}/all/#{language}.zip"
    end

    def response
      download unless File.exist?(@tmp_file)
      _read_zip
    end

    def download
      File.open(tmp_file, 'wb') do |f|
        f.binmode
        f.write _get_zip
      end
    end

    private

    def _read_zip
      ret = {}
      Zip::File.open(@tmp_file) do |f|
        f.each do |entry|
          _parse_zip(entry, ret)
        end
      end
      ret
    end

    def _get_zip
      with_caching do
        HTTParty.get(api_url)
      end
    end

    def _parse_zip(entry, return_hash)
      TVDB.logger.info("Reading #{entry}")
      content = entry.get_input_stream.read
      base_name = entry.to_s.split('.').first
      return_hash[base_name] = (MultiXml.parse(content))
    end
  end
end
