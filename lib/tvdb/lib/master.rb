module TVDB
  class Master
    attr_accessor :xml_mirrors, :banner_mirrors, :zip_mirrors
    attr_reader :api_key, :clients

    def initialize(options = {})
      key_env = options[:key_env] || 'TVDB_KEY'
      @api_key = options[:api_key] || ENV["#{key_env}"]
      @xml_mirrors = []
      @banner_mirrors = []
      @zip_mirrors = []
      @clients = []
      _setup_mirrors
    end

    def new_client(options)
      @clients << Client.new(options)
    end

    private

    def _setup_mirrors
      mirror_list = _get_mirrors
      mirror_list['Mirrors'].each do |_, info|
        _add_mirror(info)
      end
    end

    def _get_mirrors
      HTTParty.get("http://thetvdb.com/api/#{api_key}/mirrors.xml")
    end

    def _add_mirror(mirror_info)
      typemask = mirror_info['typemask']
      xml_mirrors << mirror_info['mirrorpath'] if _xml?(typemask)
      banner_mirrors << mirror_info['mirrorpath'] if _banner?(typemask)
      zip_mirrors << mirror_info['mirrorpath'] if _zip?(typemask)
    end

    def _xml?(typemask)
      typemasks[:xml].include? typemask
    end

    def _banner?(typemask)
      typemasks[:banner].include? typemask
    end

    def _zip?(typemask)
      typemasks[:zip].include? typemask
    end

    def _filter_mirrors(mirror)
      case mirror['typemask']
      when 1, 3, 5, 7
        _add_mirror(:xml, mirror)
      when 2, 3, 6, 7
        _add_mirror(:banner, mirror)
      when 4, 6, 7
        _add_mirror(:zip, mirror)
      end
    end
  end
end
