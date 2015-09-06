require 'httparty'
require_relative 'lib/options'
require_relative 'lib/mirror_list'

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

    def xml_mirror
      _format_mirror(mirror_list.xml.sample)
    end

    def banner_mirror
      _format_mirror(mirror_list.banner.sample)
    end

    def zip_mirror
      _format_mirror(mirror_list.zip.sample)
    end

    def previous_time
      HTTParty.get('http://thetvdb.com/api/Updates.php?type=none')
    end

    def languages
      @languages ||=
        HTTParty.get("#{xml_mirror}/languages.xml")['Languages']['Language']
    end

    private

    def _fetch_mirrors
      HTTParty.get("http://thetvdb.com/api/#{api_key}/mirrors.xml")
    end

    def _format_mirror(mirror_base_uri)
      "#{mirror_base_uri}/api/#{api_key}/"
    end
  end
end

require_relative './lib/client'
