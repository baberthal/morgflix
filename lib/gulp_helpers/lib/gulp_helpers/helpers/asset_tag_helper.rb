require 'action_view/helpers/asset_tag_helper'

module GulpHelpers
  module Helpers
    module AssetTagHelper
      include GulpHelpers::Helpers::Util
      include ActionView::Helpers::AssetTagHelper

      def gulp_stylesheet_link_tag(*sources)
        options = sources.extract_options!.stringify_keys
        path_options = options.extract!('protocol').symbolize_keys

        sources.uniq.map do |source|
          tag_options = {
            'rel' => 'stylesheet',
            'media' => 'screen',
            'href' => gulp_stylesheet_path(source, path_options)
          }.merge!(options)
          tag(:link, tag_options)
        end.join("\n").html_safe
      end

      def gulp_javascript_include_tag(*sources)
        options = sources.extract_options!.stringify_keys
        path_options = options.extract!('protocol', 'extname').symbolize_keys
        sources.uniq.map do |source|
          tag_opts = {
            'src' => gulp_javascript_path(source, path_options)
          }.merge!(options)
          content_tag('script'.freeze, '', tag_opts)
        end.join("\n").html_safe
      end

      def gulp_image_tag(source, options = {})
        options = options.symbolize_keys

        src = options[:src] = gulp_image_path(source)

        unless src =~ /^(?:cid|data):/ || src.blank?
          options[:alt] = options.fetch(:alt) { image_alt(src) }
        end

        options[:width], options[:height] =
          extract_dimensions(options.delete(:size)) if options[:size]
        tag('img', options)
      end
    end
  end
end
