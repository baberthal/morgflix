require 'fileutils'

module TVDB
  class Banner
    class << self
      attr_accessor :path

      def path
        @path ||= Rails.root.join('public/banners')
      end

      def download(banner)
        new(banner).download
      end
    end

    attr_reader :banner_url, :name, :banner_path

    def initialize(banner_name)
      @name = banner_name
      @banner_url = TVDB.banner_mirror
      @banner_path = self.class.path.join(banner_name)
    end

    def download
      return true if File.exist?(banner_path)
      FileUtils.mkdir_p parent_dir
      File.open(banner_path, 'wb') do |f|
        f.binmode
        f.write TVDB.get("#{banner_url}/#{name}")
      end
    end

    def parent_dir
      banner_path.dirname
    end
  end
end
