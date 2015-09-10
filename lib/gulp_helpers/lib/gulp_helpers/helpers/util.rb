module GulpHelpers
  module Helpers
    module Util
      def gulp_asset_path(path, options = {})
        options = options.symbolize_keys
        type ||= options[:type]
        path = REV_MANIFEST[path] if defined?(REV_MANIFEST)
        "/assets#{type}/#{path}"
      end

      def gulp_stylesheet_path(source, options = {})
        source.insert(-1, '.css') unless source =~ /\.(css|less|sass)$/
        options = options.symbolize_keys
        options.merge! type: GulpHelpers.stylesheet_path
        gulp_asset_path(source, options)
      end

      def gulp_javascript_path(source, options = {})
        source.insert(-1, '.js') unless source.include? '.'
        options = options.symbolize_keys
        options.merge! type: GulpHelpers.javascript_path
        gulp_asset_path(source, options)
      end

      def gulp_image_path(source, options = {})
        options = options.symbolize_keys
        options.merge! type: GulpHelpers.image_path
        gulp_asset_path(source, options)
      end
    end
  end
end
