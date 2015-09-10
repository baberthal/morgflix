module GulpHelpers
  class Config
    attr_accessor :asset_path, :options,
                  :stylesheet_path, :javascript_path, :image_path
    def initialize(opts = {})
      options = merge_defaults(opts)
      @asset_path = Pathname.new(options[:base_path])
      @stylesheet_path = options[:stylesheets]
      @javascript_path = options[:javascripts]
      @image_path = options[:images]
    end

    def stylesheet_path=(new_path)
      @stylesheet_path = _filter(new_path)
    end

    def javascript_path=(new_path)
      @javascript_path = _filter(new_path)
    end

    def image_path=(new_path)
      @image_path = _filter(new_path)
    end

    def merge_defaults(opts = {})
      opts.symbolize_keys!
      opts.each_value { |v| _filter(v) }
      {
        base_path: '/public/assets',
        stylesheets: '/stylesheets',
        javascripts: '/javascripts',
        images: '/images'
      }.merge!(opts)
    end

    def _filter(string)
      string.insert(0, '/') unless string[0] == '/'
      string
    end
  end
end
