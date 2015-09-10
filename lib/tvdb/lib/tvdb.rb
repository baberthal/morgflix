require 'httparty'
require_relative 'tvdb/options'
require_relative 'tvdb/mirror_list'

module TVDB
  class << self
    attr_accessor :mirror_list, :options

    def api_key
      options[:api_key]
    end

    def typemasks
      {
        xml: %w( 1 3 5 7 ),
        banner: %w( 2 3 6 7 ),
        zip: %w( 4 6 7 )
      }
    end

    def options
      @options ||= Options.new(api_key: ENV['TVDB_KEY'])
    end

    def options=(options)
      @options = Options.new(options)
    end

    def mirror_list
      @mirror_list ||= MirrorList.new(_fetch_mirrors)
    end

    def xml_mirror(options = {})
      _format_mirror(mirror_list.xml.sample, options)
    end

    def banner_mirror(options = {})
      _format_mirror(mirror_list.banner.sample, options)
    end

    def zip_mirror(options = {})
      _format_mirror(mirror_list.zip.sample, options)
    end

    def previous_time
      _get('http://thetvdb.com/api/Updates.php?type=none')['Items']['Time']
    end

    def languages
      @languages ||=
        _get("#{xml_mirror}/languages.xml")['Languages']['Language']
    end

    private

    def _fetch_mirrors
      _get("http://thetvdb.com/api/#{api_key}/mirrors.xml")
    end

    def _format_mirror(mirror_base_uri, options = {})
      return "#{mirror_base_uri}/api/#{api_key}" unless options
      return "#{mirror_base_uri}/api" if options[:key] == false
      "#{mirror_base_uri}/api/#{api_key}"
    end

    def _get(uri)
      HTTParty.get(uri)
    end
  end
end

require_relative 'tvdb/client'
